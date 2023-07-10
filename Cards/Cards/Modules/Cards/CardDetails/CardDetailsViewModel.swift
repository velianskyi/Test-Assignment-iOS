//
//  CardDetailsViewModel.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Foundation

final class CardDetailsViewModel: CardDetailsViewModelProtocol {
    
    // MARK: - Public Properties
    
    lazy public var state = Observable<ViewState>()
    
    var cardName: String { card.name }
    var cardNumber: String? { card.formattedDetailsNumber }
    var cardType: CardType { card.type }
    
    // MARK: - Private Properties
    
    private(set) lazy var transition = Observable<CardDetailsTransition>()
    
    private let coreDataManager: CoreDataManager
    
    private var card: Card
    
    // MARK: - Initializers
    
    init(coreDataManager: CoreDataManager, card: Card) {
        self.coreDataManager = coreDataManager
        self.card = card
    }
}

// MARK: - Public Methods
extension CardDetailsViewModel {
    public func smthTapped() {
        transition.send(.openSmth)
    }
    
    public func reloadTapped() {
        fetchCard()
    }
}

// MARK: - Private Methods
private extension CardDetailsViewModel {
    func fetchCard() {
        let result = coreDataManager.fetchCard(id: card.id)
        switch result {
        case let.success(card):
            self.card = card
            state.send(.loaded)
        case let.error(errors):
            state.send(.errors(errors))
        }
    }
}
