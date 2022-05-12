//
// NSFWModel.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class NSFWModelInput : MLFeatureProvider {

    /// input_1 as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high
    var input_1: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["input_1"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "input_1") {
            return MLFeatureValue(pixelBuffer: input_1)
        }
        return nil
    }
    
    init(input_1: CVPixelBuffer) {
        self.input_1 = input_1
    }

    convenience init(input_1With input_1: CGImage) throws {
        self.init(input_1: try MLFeatureValue(cgImage: input_1, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    convenience init(input_1At input_1: URL) throws {
        self.init(input_1: try MLFeatureValue(imageAt: input_1, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    func setInput_1(with input_1: CGImage) throws  {
        self.input_1 = try MLFeatureValue(cgImage: input_1, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

    func setInput_1(with input_1: URL) throws  {
        self.input_1 = try MLFeatureValue(imageAt: input_1, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

}


/// Model Prediction Output Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class NSFWModelOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// var_830 as multidimensional array of floats
    lazy var var_830: MLMultiArray = {
        [unowned self] in return self.provider.featureValue(for: "var_830")!.multiArrayValue
    }()!

    /// var_830 as multidimensional array of floats
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    var var_830ShapedArray: MLShapedArray<Float> {
        return MLShapedArray<Float>(self.var_830)
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(var_830: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["var_830" : MLFeatureValue(multiArray: var_830)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class NSFWModel {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "NSFWModel", withExtension:"mlmodelc")!
    }

    /**
        Construct NSFWModel instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of NSFWModel.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `NSFWModel.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct NSFWModel instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct NSFWModel instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct NSFWModel instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<NSFWModel, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct NSFWModel instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> NSFWModel {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct NSFWModel instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<NSFWModel, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(NSFWModel(model: model)))
            }
        }
    }

    /**
        Construct NSFWModel instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> NSFWModel {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return NSFWModel(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as NSFWModelInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as NSFWModelOutput
    */
    func prediction(input: NSFWModelInput) throws -> NSFWModelOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as NSFWModelInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as NSFWModelOutput
    */
    func prediction(input: NSFWModelInput, options: MLPredictionOptions) throws -> NSFWModelOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return NSFWModelOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - input_1 as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as NSFWModelOutput
    */
    func prediction(input_1: CVPixelBuffer) throws -> NSFWModelOutput {
        let input_ = NSFWModelInput(input_1: input_1)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [NSFWModelInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [NSFWModelOutput]
    */
    func predictions(inputs: [NSFWModelInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [NSFWModelOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [NSFWModelOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  NSFWModelOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
