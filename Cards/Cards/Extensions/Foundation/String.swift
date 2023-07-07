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
    // MARK: - Substring
    func masked(matching pattern: String, with template: String = "*") throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSMakeRange(0, count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: template)
    }
    
    /// Replaces the text in the range with the new specified text.
    ///
    /// Useful when implementing UITextFieldDelegate, to get new string in shouldChangeCharactersIn method.
    func replaceCharacters(inRange range: NSRange, withText string: String = "") -> String {
        guard let textRange = Range(range, in: self) else {
            return self
        }
        
        return replacingCharacters(in: textRange, with: string)
    }
}
