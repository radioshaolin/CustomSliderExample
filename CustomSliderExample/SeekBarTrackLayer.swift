//
//  SeekBarTrackLayer.swift
//  CustomSliderExample
//
//  Created by Ivan Zemlyaniy on 4/11/18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit
import QuartzCore

class SeekBarTrackLayer: CALayer {
    weak var seekBar: SeekBar?
    
    override func draw(in ctx: CGContext) {
        guard let seekBar = seekBar else { return }
        let cornerRadius: CGFloat = 0.0
        let trackHighlightedColor = seekBar.trackHighlightTintColor.cgColor
        let trackColor = seekBar.trackTintColor.cgColor
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.addPath(path.cgPath)
        ctx.setFillColor(trackColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        ctx.setFillColor(trackHighlightedColor)
        let lowerValuePosition = CGFloat(seekBar.positionForValue(seekBar.minimumValue))
        let upperValuePosition = CGFloat(seekBar.positionForValue(seekBar.currentValue))
        let rect = CGRect(x: lowerValuePosition - seekBar.thumbWidth / 2.0, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        ctx.fill(rect)
    }
}
