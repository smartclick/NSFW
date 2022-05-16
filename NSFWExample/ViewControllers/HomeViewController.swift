//
//  ViewController.swift
//  NSFWExample
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import UIKit
import Photos
import NSFW

// MARK: - Properties and super methods
class HomeViewController: UIViewController {
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var uploadButtonShadowView: UIView!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var takeButtonShadowView: UIView!
    @IBOutlet weak var attachLinkButton: UIButton!
    @IBOutlet weak var attachLinkButtonShadowView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    lazy var detector: Detector = {
        return Detector()
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.modalPresentationStyle = .fullScreen
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureShadows()
    }
}

// MARK: - Actions
extension HomeViewController {
    @IBAction func uploadButtonAction(_ sender: Any) {
        presentImagePicker(sourceType: .photoLibrary)
    }
    
    @IBAction func takeButtonAction(_ sender: Any) {
        presentImagePicker(sourceType: .camera)
    }

    
    @IBAction func attachLinkButtonAction(_ sender: Any) {
        let linkVC = UIStoryboard.instantiateLinkViewController()
        linkVC.modalPresentationStyle = .overFullScreen
        linkVC.modalTransitionStyle = .crossDissolve
        linkVC.delegate = self
        present(linkVC, animated: true)
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func configureShadows() {
        uploadButtonShadowView.dropShadow(offSet: CGSize(width: 0, height: 1),
                                          color: UIColor.black.withAlphaComponent(0.16),
                                          radius: 10,
                                          opacity: 1,
                                          cornerRadius: 10)
        takeButtonShadowView.dropShadow(offSet: CGSize(width: 0, height: 1),
                                          color: UIColor.black.withAlphaComponent(0.16),
                                          radius: 10,
                                          opacity: 1,
                                          cornerRadius: 10)
        attachLinkButtonShadowView.dropShadow(offSet: CGSize(width: 0, height: 1),
                                          color: UIColor.black.withAlphaComponent(0.16),
                                          radius: 10,
                                          opacity: 1,
                                          cornerRadius: 10)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType = .photoLibrary) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func imageSelected(image: UIImage) {
        loader.startAnimating()
        detector.scan(image: image) { [weak self] result in
            guard let self = self else {
                return
            }
            self.loader.stopAnimating()
            switch result {
            case .error(let error):
                self.showAlert(withMessage: error.localizedDescription)
            case .success(let successResult):
                print(successResult)
                self.showResultsViewController(result: successResult, image: image)
            }
        }
    }
    
    private func showResultsViewController(result: SuccessResult, image: UIImage) {
        let resultsVC = UIStoryboard.instantiateResultsViewController()
        resultsVC.resultImage = image
        resultsVC.detectResult = result
        resultsVC.modalPresentationStyle = .fullScreen
        present(resultsVC, animated: true)
    }
}

// MARK: - UIImagePickerController Delegate methods
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }        
        picker.dismiss(animated: true, completion: {
            if let selectedImage = selectedImage {
                self.imageSelected(image: selectedImage)
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        print("Image not selected")
    }
}

// MARK: - LinkViewController Delegate methods
extension HomeViewController: LinkViewControllerDelegate {
    func didAttachedLink(linkStr: String) {
        guard let url = URL(string: linkStr) else {
            return
        }
        loader.startAnimating()
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageSelected(image: image)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(withMessage: "Something went wrong")
                }
            }
        }
    }
}
