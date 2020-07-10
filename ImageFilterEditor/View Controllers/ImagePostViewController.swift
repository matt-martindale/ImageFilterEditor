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

class ImagePostViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sepiaContainerView: UIView!
    @IBOutlet weak var vignetteContainerView: UIView!
    @IBOutlet weak var noirContainerView: UIView!
    @IBOutlet weak var noiseReductionContainerView: UIView!
    @IBOutlet weak var brightnessContainerView: UIView!
    
    // MARK: - Properties
    var originalImage: UIImage? {
        didSet {
            guard let originalImage = originalImage else {
                scaledImage = nil
                return
            }
            
            var scaledSize = imageView.bounds.size
            let scale: CGFloat = UIScreen.main.scale
            
            scaledSize = CGSize(width: scaledSize.width * scale,
                                height: scaledSize.height * scale)
            
            guard let scaledUIImage = originalImage.imageByScaling(toSize: scaledSize) else {
                scaledImage = nil
                return
            }
            scaledImage = CIImage(image: scaledUIImage)
        }
    }
    
    var scaledImage: CIImage? {
        didSet {
            updateImage()
        }
    }
    
    private let context = CIContext()
    private let sepiaFilter = CIFilter.sepiaTone()
    private let vignetteFilter = CIFilter.vignette()
    private let noirFilter = CIFilter.photoEffectNoir()
    private let noiseReductionFilter = CIFilter.noiseReduction()
    private let brightnessFilter = CIFilter.colorControls().brightness
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        originalImage = imageView.image
    }
    
    // MARK: - Methods
    private func updateImage() {
        if let scaledImage = scaledImage {
//            imageView.image = image(byFiltering: scaledImage)
        } else {
            imageView.image = nil
        }
    }
    
//    private func image(byFiltering inputImage: CIImage) -> UIImage? {
//        
//        colorControlsFilter.inputImage = inputImage
//        colorControlsFilter.saturation = saturationSlider.value
//        colorControlsFilter.brightness = brightnessSlider.value
//        colorControlsFilter.contrast = contrastSlider.value
//        
//        blurFilter.inputImage = colorControlsFilter.outputImage?.clampedToExtent()
//        blurFilter.radius = blurSlider.value
//        
//        guard let outputImage = colorControlsFilter.outputImage else { return nil }
//        
//        guard let renderedCGImage = context.createCGImage(outputImage, from: inputImage.extent) else { return nil }
//        
//        return UIImage(cgImage: renderedCGImage)
//    }
    
    func setUpView() {
        sepiaContainerView.isHidden = false
        vignetteContainerView.isHidden = true
        noirContainerView.isHidden = true
        noiseReductionContainerView.isHidden = true
        brightnessContainerView.isHidden = true
    }

    @IBAction func filterSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sepiaContainerView.isHidden = false
            vignetteContainerView.isHidden = true
            noirContainerView.isHidden = true
            noiseReductionContainerView.isHidden = true
            brightnessContainerView.isHidden = true
        case 1:
            sepiaContainerView.isHidden = true
            vignetteContainerView.isHidden = false
            noirContainerView.isHidden = true
            noiseReductionContainerView.isHidden = true
            brightnessContainerView.isHidden = true
        case 2:
            sepiaContainerView.isHidden = true
            vignetteContainerView.isHidden = true
            noirContainerView.isHidden = false
            noiseReductionContainerView.isHidden = true
            brightnessContainerView.isHidden = true
        case 3:
            sepiaContainerView.isHidden = true
            vignetteContainerView.isHidden = true
            noirContainerView.isHidden = true
            noiseReductionContainerView.isHidden = false
            brightnessContainerView.isHidden = true
        case 4:
            sepiaContainerView.isHidden = true
            vignetteContainerView.isHidden = true
            noirContainerView.isHidden = true
            noiseReductionContainerView.isHidden = true
            brightnessContainerView.isHidden = false
        default:
            sepiaContainerView.isHidden = false
            vignetteContainerView.isHidden = true
            noirContainerView.isHidden = true
            noiseReductionContainerView.isHidden = true
            brightnessContainerView.isHidden = true
        }
    }
    
    @IBAction func choosePhotoButtonPressed(_ sender: Any) {
        presentImagePickerController()
    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ImagePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            originalImage = image
        } else if let image = info[.originalImage] as? UIImage {
            originalImage = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

