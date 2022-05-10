//
//  UIImage.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import UIKit

extension UIImage {
    public func resized(to newSize: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        let image = renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image
    }
}
