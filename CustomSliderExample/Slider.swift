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

    let trackLayer = SliderTrackLayer()
    let thumbLayer = SliderThumbLayer()
    
    var minimumValue: Double = 0.0
    var maximumValue: Double = 1.0
    var currentValue: Double = 0.4 {
        didSet { updateLayerFrames() }
    }
    var previousLocation = CGPoint()
    var locationY: CGFloat = 0.0
    var trackTintColor = UIColor(white: 1, alpha: 0.6) {
        didSet { trackLayer.setNeedsDisplay() }
    }
    var trackHighlightTintColor = UIColor(red: 0.13, green: 0.76, blue: 0.69, alpha: 1.0) {
        didSet { trackLayer.setNeedsDisplay() }
    }
    var thumbTintColor = UIColor(red: 0.13, green: 0.76, blue: 0.69, alpha: 1.0) {
        didSet { thumbLayer.setNeedsDisplay() }
    }
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    var curvaceousness : CGFloat = 1

    override var frame: CGRect {
        didSet { updateLayerFrames() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.slider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        thumbLayer.slider = self
        thumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(thumbLayer)
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        locationY = touch.location(in: self).y
        if thumbLayer.frame.contains(previousLocation) {
            thumbLayer.highlighted = true
        }
        return thumbLayer.highlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        previousLocation = location
        locationY = touch.location(in: self).y
        if thumbLayer.highlighted {
            currentValue += deltaValue
            currentValue = boundValue(value: currentValue,
                                      lowerValue: minimumValue,
                                      upperValue: maximumValue)
        }
        sendActions(for: .valueChanged)
        sendActions(for: .touchDragExit)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbLayer.highlighted = false
    }
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        let currentThumbCenter = CGFloat(positionForValue(currentValue))
        thumbLayer.frame = CGRect(x: currentThumbCenter - thumbWidth / 2.0,
                                  y: 0.0,
                                  width: thumbWidth,
                                  height: thumbWidth)
        thumbLayer.setNeedsDisplay()
        CATransaction.commit()
    }
    
    func positionForValue(_ value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    func boundValue(value: Double, lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    
}
