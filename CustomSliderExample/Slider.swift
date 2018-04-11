//
//  Slider.swift
//  CustomSliderExample
//
//  Created by radioshaolin on 10.04.18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit
import QuartzCore

class Slider: UIControl {

    var minimumValue = 0.0
    var maximumValue = 1.0
    var currentValue = 0.4
    
    var previousLocation = CGPoint()
    let trackLayer = CALayer()
    let thumbLayer = SliderThumbLayer()
    
    override var frame: CGRect {
        didSet { updateLayerFrames() }
    }
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(trackLayer)
        
        thumbLayer.backgroundColor = UIColor.green.cgColor
        layer.addSublayer(thumbLayer)
        
        thumbLayer.slider = self
        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let currentThumbCenter = CGFloat(positionForValue(currentValue))
        thumbLayer.frame = CGRect(x: currentThumbCenter - thumbWidth / 2.0, y: 0.0,
                                       width: thumbWidth, height: thumbWidth)
        thumbLayer.setNeedsDisplay()
        
    }
    
    func positionForValue(_ value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    
}
