//
//  LinkViewController.swift
//  NSFWExample
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import UIKit

// MARK: - LinkViewControllerDelegate defination
protocol LinkViewControllerDelegate: AnyObject {
    func didAttachedLink(linkStr: String)
}

// MARK: - Properties
class LinkViewController: UIViewController {
    @IBOutlet weak var imageLinkTextField: UITextField!

    weak var delegate: LinkViewControllerDelegate?
}

// MARK: - View lifecycle
extension LinkViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
    }
}

// MARK: - Actions
extension LinkViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func attachButtonAction(_ sender: Any) {
        if verifyUrl(urlString: imageLinkTextField.text) {
            dismiss(animated: true)
            delegate?.didAttachedLink(linkStr: imageLinkTextField.text!)
        } else {
            showAlert(withMessage: "Invalid Link")
        }
    }

    @IBAction func pasteButtonAction(_ sender: Any) {
        let pasteBoard = UIPasteboard.general
        imageLinkTextField.text = pasteBoard.string
    }
}

// MARK: - Private methods
extension LinkViewController {
    private func addTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}
