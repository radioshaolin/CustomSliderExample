//
//  SliderTrackLayer.swift
//  CustomSliderExample
//
//  Created by Ivan Zemlyaniy on 4/11/18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit
import QuartzCore

class SliderTrackLayer: CALayer {
    weak var slider: Slider?
    
    override func draw(in ctx: CGContext) {
        guard let slider = slider else { return }
        let cornerRadius: CGFloat = 0 // bounds.height * slider.curvaceousness / 2.0
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.addPath(path.cgPath)
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.addPath(path.cgPath)
        (ctx).fillPath()
        
        ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
        let lowerValuePosition = CGFloat(slider.positionForValue(slider.minimumValue))
        let upperValuePosition = CGFloat(slider.positionForValue(slider.currentValue))
        let rect = CGRect(x: lowerValuePosition - slider.thumbWidth / 2, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        ctx.fill(rect)
    }
}
