//
//  SeekBarThumbLayer.swift
//  CustomSliderExample
//
//  Created by radioshaolin on 10.04.18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit
import QuartzCore

class SeekBarThumbLayer: CALayer {
    weak var seekBar: SeekBar?
    var highlighted = false {
        didSet { setNeedsDisplay() }
    }

    override func draw(in ctx: CGContext) {
        guard let seekBar = seekBar else { return }
        let thumbColor = seekBar.thumbTintColor.cgColor
        let shadowColor = seekBar.thumbTintColor.withAlphaComponent(0.5).cgColor
        let cornerRadius = seekBar.thumbWidth / 2
        let thumbPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.setFillColor(thumbColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()
        ctx.setStrokeColor(shadowColor)
        ctx.setLineWidth(0.6)
        ctx.addPath(thumbPath.cgPath)
        ctx.strokePath()        
        if highlighted {
            ctx.setFillColor(shadowColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
        }
    }
    
}
