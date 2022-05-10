//
//  SuccessResult.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import Foundation

public struct SuccessResult: CustomStringConvertible {
    public let drawing: Float
    public let hentai: Float
    public let neutral: Float
    public let provocative: Float
    public let pornagraphic: Float
    
    public init(results: [Float]) {
        guard results.count == 5 else {
            fatalError("NSFW results count always be 5")
        }
        self.drawing = results[0]
        self.hentai = results[1]
        self.neutral = results[2]
        self.provocative = results[3]
        self.pornagraphic = results[4]
    }
    
    public var description: String {
        return "drawing: \(drawing), hentai: \(hentai), neutral: \(neutral), provocative: \(provocative), pornagraphic: \(pornagraphic)"
    }
}
