//
//  CardDetailsViewModelProtocol.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Combine

protocol CardDetailsViewModelProtocol: AnyObject {
    var state: AnyPublisher<ViewState, Never> { get }
    
    var cardName: String { get }
    var cardNumber: String? { get }
    var cardType: CardType { get }
    
    func smthTapped()
    func reloadTapped()
}
