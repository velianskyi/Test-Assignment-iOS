//
//  UINavigationController.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit

extension UINavigationController {
    /// Push view controller method with completion.
    func pushViewController(
        viewController: UIViewController,
        animated: Bool,
        completion: Block?
    ) {
        makeTransaction(with: completion) {
            pushViewController(viewController, animated: animated)
        }
    }
    
    /// Pop view controller method with completion.
    func popViewController(
        animated: Bool,
        completion: Block?
    ) {
        makeTransaction(with: completion) {
            popViewController(animated: animated)
        }
    }
    
    /// Set view controllers method with completion.
    func setViewControllers(
        _ viewControllers: [UIViewController],
        _ animated: Bool,
        completion: Block?
    ) {
        makeTransaction(with: completion) {
            setViewControllers(viewControllers, animated: animated)
        }
    }
}

// MARK: - Private Methods
private extension UINavigationController {
    func makeTransaction(with completion: Block?, _ action: Block) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        action()
        CATransaction.commit()
    }
}
