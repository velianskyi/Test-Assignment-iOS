//
//  Constants.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import Foundation

// TODO: - Naming

typealias Token         = String
typealias ErrorsDict    = Dictionary<String, Error> // For errors from server response

// TODO: - Closures

typealias Func = ()
typealias Block = () -> Void
typealias ValueBlock<T> = (T) -> Void
typealias OptionalValueBlock<T> = (T?) -> Void

// MARK: - Enums

enum Result<T> {
    case success(T)
    case error(ErrorsDict)
}
