//
//  Error.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Foundation

// MARK: - App Errors

enum AppError: Error, LocalizedError {
    case unknownError
    case custom(text: String)
    
    var errorDescription: String? {
        switch self {
        case .unknownError: return "Unknown Error"
        case .custom(let text): return text
        }
    }
}

// MARK: - Response Key Errors

enum ResponseKeyError: String {
    case nonField = "non_field_errors"
    
    var title: String {
        switch self {
        case .nonField  : return "Error"
        }
    }
}

// MARK: - Errors Dictionary

extension Dictionary where Key == String, Value == Error {
    init(error: Error) {
        self.init()
        self[ResponseKeyError.nonField.rawValue] = error
    }
    
    init(errorMessage: String) {
        let error = AppError.custom(text: errorMessage)
        self.init(error: error)
    }
}
