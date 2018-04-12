//
//  SeekBar.swift
//  CustomSliderExample
//
//  Created by radioshaolin on 10.04.18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class SeekBar: UIControl {
    let trackLayer = SeekBarTrackLayer()
    let thumbLayer = SeekBarThumbLayer()
    var previousLocationX: CGPoint = CGPoint()
    var previousLocationY: CGPoint = CGPoint()

    @IBInspectable var minimumValue: Double = C.minimumValue
    @IBInspectable var maximumValue: Double = C.maximumValue
    @IBInspectable var currentValue: Double = 0 {
        didSet { updateLayerFrames() }
    }
    @IBInspectable var thumbWidth: CGFloat = C.thumbWidth {
        didSet { updateLayerFrames() }
    }
    @IBInspectable var trackLayerHeight: CGFloat = C.trackLayerHeight {
        didSet { updateLayerFrames() }
    }
    @IBInspectable var trackTintColor: UIColor = C.trackTintColor {
        didSet { trackLayer.setNeedsDisplay() }
    }
    @IBInspectable var trackHighlightTintColor: UIColor = C.trackHighlightTintColor {
        didSet { trackLayer.setNeedsDisplay() }
    }
    @IBInspectable var thumbTintColor: UIColor = C.thumbTintColor {
        didSet { thumbLayer.setNeedsDisplay() }
    }

    override var frame: CGRect {
        didSet { updateLayerFrames() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        trackLayer.seekBar = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        thumbLayer.seekBar = self
        thumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(thumbLayer)
        updateLayerFrames()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocationX = touch.location(in: self)
        previousLocationY = touch.location(in: self)
        if thumbLayer.frame.contains(previousLocationX) {
            thumbLayer.highlighted = true
        }
        return thumbLayer.highlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let deltaLocation = Double(location.x - previousLocationX.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        previousLocationX = location
        previousLocationY = location
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
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let relativeFrame = self.bounds
//        let hitTestEdgeInsets = UIEdgeInsetsMake(-50, -50, -50, -50)
//        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
//        return hitFrame.contains(point)
//    }
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        trackLayer.frame = CGRect(x: 0, y: bounds.height / 2.0 , width: bounds.width, height: trackLayerHeight)
        trackLayer.setNeedsDisplay()
        let currentThumbCenter = CGFloat(positionForValue(currentValue))
        thumbLayer.frame = CGRect(x: currentThumbCenter - thumbWidth / 2.0,
                                  y: bounds.height / 2.0 + trackLayerHeight / 2.0 - thumbWidth / 2.0,
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

private extension SeekBar {
    struct C {
        static let minimumValue = 0.0
        static let maximumValue = 1.0
        static let thumbWidth = CGFloat(18.0)
        static let trackLayerHeight = CGFloat(4.0)
        static let trackTintColor = UIColor(white: 1, alpha: 0.4)
        static let trackHighlightTintColor = UIColor(red: 0.13, green: 0.76, blue: 0.69, alpha: 1.0)
        static let thumbTintColor = UIColor(red: 0.13, green: 0.76, blue: 0.69, alpha: 1.0)
    }
}

private var pTouchAreaEdgeInsets: UIEdgeInsets = .zero
extension UIControl {
    var touchAreaEdgeInsets: UIEdgeInsets {
        get {
            if let value = objc_getAssociatedObject(self, &pTouchAreaEdgeInsets) as? NSValue {
                var edgeInsets: UIEdgeInsets = .zero
                value.getValue(&edgeInsets)
                return edgeInsets
            }
            else {
                return .zero
            }
        }
        set(newValue) {
            var newValueCopy = newValue
            let objCType = NSValue(uiEdgeInsets: .zero).objCType
            let value = NSValue(&newValueCopy, withObjCType: objCType)
            objc_setAssociatedObject(self, &pTouchAreaEdgeInsets, value, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if UIEdgeInsetsEqualToEdgeInsets(self.touchAreaEdgeInsets, .zero) || !self.isEnabled || self.isHidden {
            return super.point(inside: point, with: event)
        }
        
        let relativeFrame = self.bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.touchAreaEdgeInsets)
        
        return hitFrame.contains(point)
    }
}

