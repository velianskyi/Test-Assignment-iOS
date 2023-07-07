//
//  ViewState.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import Foundation

protocol CommonViewStateProtocol {
    static var loading: Self { get }
    
    static func errors(_ errors: ErrorsDict) -> Self
}

enum ViewState: CommonViewStateProtocol {
    case view
    case loading
    case loaded
    case errors(_ errors: ErrorsDict)
}
