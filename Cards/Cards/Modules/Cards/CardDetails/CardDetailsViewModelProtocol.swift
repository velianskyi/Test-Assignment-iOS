//
//  CardDetailsViewModelProtocol.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Foundation

protocol CardDetailsViewModelProtocol: AnyObject {
    var state: Observable<ViewState> { get }
    
    var cardName: String { get }
    var cardNumber: String? { get }
    var cardType: CardType { get }
    
    func smthTapped()
    func reloadTapped()
}
