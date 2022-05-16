//
//  ResultViewController.swift
//  NSFWExample
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import UIKit
import NSFW

class ResultViewController: UIViewController {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var drawingConfLabel: UILabel!
    @IBOutlet weak var drawingPercLabel: UILabel!
    @IBOutlet weak var hentaiConfLabel: UILabel!
    @IBOutlet weak var hentaiPercLabel: UILabel!
    @IBOutlet weak var neutralConfLabel: UILabel!
    @IBOutlet weak var neutralPercLabel: UILabel!
    @IBOutlet weak var sexyConfLabel: UILabel!
    @IBOutlet weak var sexyPercLabel: UILabel!
    @IBOutlet weak var pornographicConfLabel: UILabel!
    @IBOutlet weak var pornographicPercLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!        
    
    var resultImage: UIImage?
    var detectResult: SuccessResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage()
        updateUI()
    }
}

// MARK: - Actions
extension ResultViewController {
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Private methods
extension ResultViewController {
    private func updateUI() {
        guard let detectResult = detectResult else {
            fatalError("Detect result can't be nil")
        }
        drawingConfLabel.text = detectResult.drawing.toString()
        hentaiConfLabel.text = detectResult.hentai.toString()
        neutralConfLabel.text = detectResult.neutral.toString()
        sexyConfLabel.text = detectResult.sexy.toString()
        pornographicConfLabel.text = detectResult.pornagraphic.toString()
        drawingPercLabel.text = detectResult.drawing.toStringPercent()
        hentaiPercLabel.text = detectResult.hentai.toStringPercent()
        neutralPercLabel.text = detectResult.neutral.toStringPercent()
        sexyPercLabel.text = detectResult.sexy.toStringPercent()
        pornographicPercLabel.text = detectResult.pornagraphic.toStringPercent()
    }
    
    private func updateImage() {
        guard let resultImage = resultImage else {
            fatalError("Result Image can't be nil")
        }
        mainImageView.image = resultImage
    }
}
