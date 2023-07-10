//
//  CardDetailsModuleBuilder.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

enum CardDetailsTransition: Transition {
    case openSmth
}

final class CardDetailsModuleBuilder {
    class func build(appContainer: AppContainer, card: Card) -> Module<CardDetailsTransition> {
        let viewModel = CardDetailsViewModel(coreDataManager: appContainer.coreDataManager, card: card)
        let viewController = CardDetailsVC.instantiate(viewModel)
        
        return Module(transitionPublisher: viewModel.transition, viewController: viewController)
    }
}
