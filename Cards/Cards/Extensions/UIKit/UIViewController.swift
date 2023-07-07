//
//  UIViewController.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit

// MARK: - Properties
public extension UIViewController {
    /// Contrller string describtion
    static var identifier: String { return String(describing: self) }
}

// MARK: - Methods
public extension UIViewController {
    /// Remove back button from native navigation bar
    func removeBackButtonTitle() {
        DispatchQueue.main.async {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(
                title: .empty, style: .plain, target: nil, action: nil
            )
        }
    }
}
