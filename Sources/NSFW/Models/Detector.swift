//
//  Detector.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import Vision
import CoreML

public class Detectror {
    private let nsfwModel: VNCoreMLModel

    public required init() {
        let configuration = MLModelConfiguration()
        #if canImport(UIKit)
        guard let nsfwModel = try? VNCoreMLModel(for: NSFWModel(configuration: configuration).model) else {
            fatalError("NSFW Model should always be valid")
        }
        #elseif canImport(AppKit)
        let url = Bundle.main.url(forResource: "NSFWModel", withExtension:"mlmodelc")!
        guard let nsfwModel = try? VNCoreMLModel(for: MLModel(contentsOf: url, configuration: configuration)) else {
            fatalError("NSFW Model should always be valid")
        }
        #endif
        self.nsfwModel = nsfwModel
    }
        
    public func scan(image: ImageType, completion: @escaping (_ result: Result) -> Void) {
        let resizedImage = image.resized(to: CGSize(width: 224, height: 224))
        let requestHandler: VNImageRequestHandler?
        if let cgImage = resizedImage.cgImage {
            requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        } else if let ciImage = resizedImage.ciImage {
            requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        } else {
            requestHandler = nil
        }
        makeRequest(requestHandler: requestHandler, completion: completion)
    }
}

private extension Detectror {
    private func makeRequest(requestHandler: VNImageRequestHandler?, completion: @escaping (_ result: Result) -> Void) {
        guard let requestHandler = requestHandler else {
            completion(.error(NSError(domain: "either cgImage or ciImage must be set inside of UIImage", code: 0, userInfo: nil)))
            return
        }
        let request = VNCoreMLRequest(model: self.nsfwModel, completionHandler: { [weak self] (request, error) in
            guard let self = self,
                  let observations = request.results as? [VNCoreMLFeatureValueObservation],
                  let segmentationmap = observations.first?.featureValue.multiArrayValue  else {
                completion(.error(NSError(domain: "Detection failed: No NSFW Observation found", code: 0, userInfo: nil)))
                return
            }
            completion(.success(successResult: self.configureSuccessResult(multiArrayValue: segmentationmap)))
        })
        do {
            try requestHandler.perform([request])
        } catch {
            completion(.error(NSError(domain: "Detection failed: No NSFW Observation found", code: 0, userInfo: nil)))
        }
    }
    
    private func configureSuccessResult(multiArrayValue: MLMultiArray) -> SuccessResult {
        var floatVals: [Float] = []
        for ind in 0..<multiArrayValue.count {
            floatVals.append(multiArrayValue[ind].floatValue)
        }
        return SuccessResult(results: floatVals.softmax())
    }
}
