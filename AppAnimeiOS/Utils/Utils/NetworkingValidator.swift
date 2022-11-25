//
//  NetworkingValidator.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import Foundation

enum NetworkingValidator {
    
    static func isImage(response: URLResponse?) -> Bool {
        guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else {
            return false
        }
        return true
    }
    
    static func isValidStatusCode(response: URLResponse?) -> Bool {
        guard let response = (response as? HTTPURLResponse) else {
            return false
        }
        return isValidStatusCode(response: response)
    }
    
    static func isValidStatusCode(response: HTTPURLResponse) -> Bool {
        200 ... 299 ~= response.statusCode
    }
    
    static func isFulfilledStatusCode(response: URLResponse?) -> Bool {
        guard let response = (response as? HTTPURLResponse) else {
            return false
        }
        return isFulfilledStatusCode(response: response)

    }
    
    static func isFulfilledStatusCode(response: HTTPURLResponse) -> Bool {
        response.statusCode == 200
    }
    
}
