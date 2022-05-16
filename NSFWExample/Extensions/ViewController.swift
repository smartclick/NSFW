//
//  ViewController.swift
//  NSFWExample
//
//  Created by Sevak Soghoyan on 5/16/22.
//

import UIKit

extension UIViewController {
    func showAlert(withMessage message: String, okAction:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message,
                                                preferredStyle: UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertAction.Style.default) { _ -> Void in
            okAction?()
        })
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
