//
//  Errors.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/17/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


struct Errors {
    
    enum Domains: String {
        case ResponseObject = "ResponseObject"
        case Internal = "Internal"
    }
    
    
    enum Codes: Int {
        case UnexpectedResponseDataStructure = -5000
        case Internal
    }
    
    
    static func unexpectedResponseDataStructureError() -> Error {
        return NSError(domain: Domains.ResponseObject.rawValue,
                       code: Codes.UnexpectedResponseDataStructure.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Unexpected response data structure."])
    }
    
    
    static func internalError() -> Error {
        return NSError(domain: Domains.Internal.rawValue,
                       code: Codes.Internal.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Internal Error."])
    }
}
