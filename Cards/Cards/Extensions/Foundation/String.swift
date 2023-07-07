//
//  String.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import Foundation

// MARK: - Properties
public extension String {
    static let empty: String = ""
    static let space: String = " "
}

// MARK: - Methods
public extension String {
    func masked(matching pattern: String, with template: String = "*") throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSMakeRange(0, count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: template)
    }
}
