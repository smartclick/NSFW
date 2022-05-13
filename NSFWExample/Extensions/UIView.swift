//
//  UIView.swift
//  NSFWExample
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import UIKit

extension UIView {
    func dropShadow(offSet: CGSize = CGSize.zero,
                    color: UIColor = .black,
                    radius: CGFloat = 2,
                    opacity: Float = 1.0,
                    spread: CGFloat = 0,
                    cornerRadius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.cornerRadius = cornerRadius
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dxVal = -spread
            let rect = bounds.insetBy(dx: dxVal, dy: dxVal)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
