//
//  CardsListViewModelProtocol.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Combine

protocol CardsListViewModelProtocol: AnyObject {
    var state: AnyPublisher<ViewState, Never> { get }
    var numberOfRows: Int { get }
    
    func addCardTapped()
    func trashCardsTapped()
    func openCardDetail(index: Int)
    
    subscript (modelFor index: Int) -> CardsTVCModel? { get }
}
