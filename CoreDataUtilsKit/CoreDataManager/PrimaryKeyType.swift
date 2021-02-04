//
//  PrimaryKey.swift
//  Hager Data Kit
//
//  Created by RGMC on 17/01/2018.
//  Copyright © 2018 RGMC. All rights reserved.
//

import Foundation

internal func primaryKeyfrom(_ value: Any?) -> PrimaryKeyType? {
    var output:PrimaryKeyType? = nil
    if let value = value as? String { output = PrimaryKeyType.string(value) }
    if let value = value as? Int { output = PrimaryKeyType.int(value) }
    assert(output != nil, "your primary Key must be eather an INT or a STRING")
    return output
}

enum PrimaryKeyType {
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

/**
 this protocole is used to limit fetches and creation with id of type INT or String (nothing else)
 it's like a type Alias for 2 type (string and int)
 */
public protocol PrimaryKey {

}
extension String: PrimaryKey {

}
extension Int: PrimaryKey {

}
