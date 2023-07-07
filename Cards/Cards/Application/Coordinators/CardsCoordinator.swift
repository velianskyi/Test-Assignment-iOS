//
//  CardsCoordinator.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit
import Combine

final class CardsCoordinator: Coordinator {
    
    // MARK: - Internal Properties
    
    weak var parent: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var subscriptions: Set<AnyCancellable>
    var appContainer: AppContainer
    
    // MARK: - Initializers
    
    required init(parent: Coordinator? = nil,
                  navigationController: UINavigationController? = nil,
                  appContainer: AppContainer) {
        self.parent = parent
        self.childCoordinators = [Coordinator]()
        self.navigationController = navigationController ?? UINavigationController()
        self.navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.subscriptions = Set<AnyCancellable>()
        self.appContainer = appContainer
    }
    
    // MARK: - Lifecycle
    
    func start() {
        showCardsList()
    }
}

// MARK: - Private Methods
private extension CardsCoordinator {
    func showCardsList() {
        let module = CardsListModuleBuilder.build(appContainer: appContainer)
        
        module.transitionPublisher
            .sink { [weak self] action in
                guard let self = self else { return }
                
                switch action {
                case let.openCardDetails(card):
                    self.showCardDetails(card)
                }
            }
            .store(in: &subscriptions)
        
        pushModule(module.viewController)
    }
    
    func showCardDetails(_ card: Card){
        print(card)
    }
}
