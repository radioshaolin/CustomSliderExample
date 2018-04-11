//
//  SliderThumbLayer.swift
//  CustomSliderExample
//
//  Created by radioshaolin on 10.04.18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit
import QuartzCore

class SliderThumbLayer: CALayer {
    weak var slider: Slider?
    var highlighted = false {
        didSet { setNeedsDisplay() }
    }

    override func draw(in ctx: CGContext) {
        guard let slider = slider else { return }
        let thumbFrame = bounds.insetBy(dx: -2.0, dy: -2.0)
        let cornerRadius = thumbFrame.height / 2
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
        let shadowColor = slider.thumbTintColor
        ctx.setShadow(offset: CGSize(width: 0.0, height: 1.0), blur: 1.0, color: shadowColor.cgColor)
        ctx.setFillColor(slider.thumbTintColor.cgColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()
        
        // Outline
        ctx.setStrokeColor(shadowColor.cgColor)
        ctx.setLineWidth(3)
        ctx.addPath(thumbPath.cgPath)
        ctx.strokePath()
        
        if highlighted {
            ctx.setFillColor(UIColor.white.withAlphaComponent(0.1).cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
        }
    }
    
}
