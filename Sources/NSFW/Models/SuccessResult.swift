//
//  SuccessResult.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import Foundation

public struct SuccessResult: CustomStringConvertible {
    public let explicit: Float
    public let neutral: Float
    public let suggestive: Float
    
    public init(results: [Float]) {
        guard results.count == 3 else {
            fatalError("NSFW results count always be 3")
        }
        self.explicit = results[0]
        self.neutral = results[1]
        self.suggestive = results[2]
    }
    
    public var description: String {
        return "explicit: \(explicit), neutral: \(neutral), suggestive: \(suggestive)"
    }
}
