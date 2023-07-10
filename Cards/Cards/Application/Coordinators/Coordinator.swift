//
//  Coordinator.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    
    // MARK: - Internal Properties
    
    var parent: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var appContainer: AppContainer { get set }
    
    // MARK: - Initializers
    
    init(parent: Coordinator?, navigationController: UINavigationController?, appContainer: AppContainer)
    
    // MARK: - Lifecycle
    
    func start()
}

// MARK: - Internal Methods
extension Coordinator {
    func pushModule(
        _ vc: UIViewController,
        navigationController: UINavigationController? = nil,
        animated: Bool = true,
        completion: Block? = nil
    ) {
        let navigationController = navigationController ?? self.navigationController
        
        navigationController.pushViewController(
            viewController: vc, animated: animated, completion: completion
        )
    }
    
    func popModule() {
        navigationController.popViewController(animated: true)
    }
}
