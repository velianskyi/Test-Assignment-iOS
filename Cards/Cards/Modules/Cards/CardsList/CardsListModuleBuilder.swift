//
//  CardsListModuleBuilder.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

enum CardsListTransition: Transition {
    case openCardDetails(_ card: Card)
}

final class CardsListModuleBuilder {
    class func build(appContainer: AppContainer) -> Module<CardsListTransition> {
        let viewModel = CardsListViewModel(coreDataManager: appContainer.coreDataManager)
        let viewController = CardsListVC.instantiate(viewModel)
        
        return Module(transitionPublisher: viewModel.transition, viewController: viewController)
    }
}
