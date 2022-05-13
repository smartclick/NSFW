//
//  NSImage.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/11/22.
//
#if canImport(AppKit)
import AppKit

extension NSImage {
    func resized(to newSize: NSSize) -> NSImage {
        if let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil, pixelsWide: Int(newSize.width), pixelsHigh: Int(newSize.height),
            bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
            colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0
        ) {
            bitmapRep.size = newSize
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
            draw(in: NSRect(x: 0, y: 0, width: newSize.width, height: newSize.height), from: .zero, operation: .copy, fraction: 1.0)
            NSGraphicsContext.restoreGraphicsState()

            let resizedImage = NSImage(size: newSize)
            resizedImage.addRepresentation(bitmapRep)
            return resizedImage
        }

        return self
    }
    
    @objc var cgImage: CGImage? {
        get {
            guard let imageData = self.tiffRepresentation,
                  let sourceData = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
            return CGImageSourceCreateImageAtIndex(sourceData, 0, nil)
        }
    }
    
    @objc var ciImage: CIImage? {
        get {
            guard let imageData = self.tiffRepresentation,
                  let bitmap = NSBitmapImageRep(data: imageData) else { return nil }
            return CIImage(bitmapImageRep: bitmap)
        }
    }
    
    
}
#endif
