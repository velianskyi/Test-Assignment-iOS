//
//  CardsListViewModel.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import Foundation

final class CardsListViewModel: CardsListViewModelProtocol {
    
    // MARK: - Public Properties
    
    lazy public var state = Observable<ViewState>()
    public var numberOfRows: Int { cards.count }
    
    // MARK: - Private Properties
    
    private(set) lazy var transition = Observable<CardsListTransition>()
    
    private let coreDataManager: CoreDataManager
    
    private var cards: [Card] = []
    
    private let cardNames: [String] = ["National Bank", "First Bank", "Unity Bank", "Active Bank", "Any Bank"]
    private let cardNumbers: [String] = ["4331149864301012", "4214979757521801", "4323849008641476",
                                         "4144620086399072", "4778901714966687", "4682158840536794"]
    private let cardExpMonth: [Int16] = [01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12]
    private let cardExpYear: [Int16] = [2024, 2025, 2026, 2027, 2028, 2029]
    
    // MARK: - Initializers
    
    required init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.fetchCards()
    }
    
    // MARK: - Subscripts
    
    subscript (modelFor index: Int) -> CardsTVCModel? {
        guard let model = cards[safe: index] else { return nil }
        return model.createTVCModel()
    }
}

// MARK: - Public Methods
extension CardsListViewModel {
    public func addCardTapped() {
        coreDataManager.createCard(
            name: cardNames.randomElement() ?? "Bank",
            number: cardNumbers.randomElement() ?? "1234 1234 1234 1234",
            expMonth: cardExpMonth.randomElement() ?? 01,
            expYear: cardExpYear.randomElement() ?? 2024,
            type: .allCases.randomElement() ?? .visa
        )
        fetchCards()
    }
    
    public func trashCardsTapped() {
        let result = coreDataManager.deleteCards()
        handleCardResult(result: result)
    }
    
    public func openCardDetail(index: Int) {
        transition.send(.openCardDetails(cards[index]))
    }
}

private extension CardsListViewModel {
    func fetchCards() {
        let result = coreDataManager.fetchCards()
        handleCardResult(result: result)
    }
    
    func handleCardResult(result: Result<[Card]>) {
        switch result {
        case let.success(cards):
            self.cards = cards
            state.send(.loaded)
        case let.error(errors):
            state.send(.errors(errors))
        }
    }
}
