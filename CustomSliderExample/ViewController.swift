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
        
        slider.backgroundColor = .red
        view.addSubview(slider)
        
    }

    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - margin * 2
        slider.frame = CGRect(x: margin, y: margin * 2, width: width, height: 31)
        
    }


}

