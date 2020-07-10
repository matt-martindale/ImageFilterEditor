//
//  ViewController.swift
//  ImageFilterEditor
//
//  Created by Matthew Martindale on 7/8/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class FiltersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private let sepiaFilter = CIFilter.sepiaTone()
    private let vignetteFilter = CIFilter.vignette()
    private let noirFilter = CIFilter.photoEffectNoir()
    private let noiseReductionFilter = CIFilter.noiseReduction()
    private let brightnessFilter = CIFilter.colorControls().brightness

}

