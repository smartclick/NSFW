//
//  Image.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/11/22.
//

import Foundation

#if canImport(UIKit)
    import UIKit.UIImage
    public typealias ImageType = UIImage
#elseif canImport(AppKit)
    import AppKit.NSImage
    public typealias ImageType = NSImage
#endif

/// An alias for the SDK's image type.
public typealias Image = ImageType
