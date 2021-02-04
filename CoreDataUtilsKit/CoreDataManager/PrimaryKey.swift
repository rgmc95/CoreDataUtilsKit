//
//  PrimaryKey.swift
//  Hager Data Kit
//
//  Created by RGMC on 17/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

internal func primaryKeyfrom(_ value: Any?) -> PrimaryKey? {
    var output:PrimaryKey? = nil
    if let value = value as? String { output = PrimaryKey.string(value) }
    if let value = value as? Int { output = PrimaryKey.int(value) }
    assert(output != nil, "your primary Key must be eather an INT or a STRING")
    return output
}

enum PrimaryKey {
    case string(String)
    case int(Int)

    var value: String {
        switch self {
        case .int(let cValue):
            return String(cValue)
        case .string(let cValue):
            return cValue
        }
    }
}
