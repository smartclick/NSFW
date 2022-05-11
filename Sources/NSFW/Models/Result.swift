//
//  Result.swift
//  NSFW
//
//  Created by Sevak Soghoyan on 5/10/22.
//

import Foundation

public enum Result {
    case error(Error)
    case success(successResult: SuccessResult)
}
