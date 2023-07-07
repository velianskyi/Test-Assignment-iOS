//
//  CardDetailsViewModel.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Combine

final class CardDetailsViewModel: CardDetailsViewModelProtocol {
    
    // MARK: - Public Properties
    
    lazy public var state: AnyPublisher<ViewState, Never> = stateSubject.eraseToAnyPublisher()
    
    var cardName: String { card.name }
    var cardNumber: String? { card.formattedDetailsNumber }
    var cardType: CardType { card.type }
    
    // MARK: - Private Properties
    
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<CardDetailsTransition, Never>()
    private let stateSubject = PassthroughSubject<ViewState, Never>()
    
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
        transitionSubject.send(.openSmth)
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
            stateSubject.send(.loaded)
        case let.error(errors):
            stateSubject.send(.errors(errors))
        }
    }
}
