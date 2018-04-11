//
//  ViewController.swift
//  CustomSliderExample
//
//  Created by radioshaolin on 10.04.18.
//  Copyright © 2018 Radio Shaolin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let slider = Slider(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(slider)
        slider.addTarget(self, action: #selector(ViewController.sliderXValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(ViewController.sliderYValueChanged), for: .touchDragExit)
    }

    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 40.0
        let width = view.bounds.width - margin * 2
        slider.frame = CGRect(x: margin, y: UIApplication.shared.statusBarFrame.height + CGFloat(100.0), width: width, height: 40)
    }

    @objc func sliderXValueChanged() {
        print("Current X value: \(slider.currentValue)")
    }
    
    @objc func sliderYValueChanged() {
        print("Current y value: \(slider.locationY)")
    }
}

