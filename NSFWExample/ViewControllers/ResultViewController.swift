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
    @IBOutlet weak var explicitConfLabel: UILabel!
    @IBOutlet weak var explicitPercLabel: UILabel!
    @IBOutlet weak var suggestiveConfLabel: UILabel!
    @IBOutlet weak var suggestivePercLabel: UILabel!
    @IBOutlet weak var neutralConfLabel: UILabel!
    @IBOutlet weak var neutralPercLabel: UILabel!
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
        explicitConfLabel.text = detectResult.explicit.toString()
        suggestiveConfLabel.text = detectResult.suggestive.toString()
        neutralConfLabel.text = detectResult.neutral.toString()
        explicitPercLabel.text = detectResult.explicit.toStringPercent()
        suggestivePercLabel.text = detectResult.suggestive.toStringPercent()
        neutralPercLabel.text = detectResult.neutral.toStringPercent()
    }
    
    private func updateImage() {
        guard let resultImage = resultImage else {
            fatalError("Result Image can't be nil")
        }
        mainImageView.image = resultImage
    }
}
