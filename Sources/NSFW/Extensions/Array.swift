//
//  Array.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import Foundation
import Accelerate

extension Array where Element == Float {
    public func softmax() -> [Float] {
        var result: [Float] = self
        let len = vDSP_Length(result.count)
        
        // Find the maximum value in the input array.
        var max: Float = 0
        vDSP_maxv(result, 1, &max, len)
        
        // Subtract the maximum from all the elements in the array.
        // Now the highest value in the array is 0.
        max = -max
        vDSP_vsadd(result, 1, &max, &result, 1, len)
        
        // Exponentiate all the elements in the array.
        var count = Int32(result.count)
        vvexpf(&result, result, &count)
        
        // Compute the sum of all exponentiated values.
        var sum: Float = 0
        vDSP_sve(result, 1, &sum, len)
        
        // Divide each element by the sum. This normalizes the array contents
        // so that they all add up to 1.
        vDSP_vsdiv(result, 1, &sum, &result, 1, len)
        
        return result
    }
}

