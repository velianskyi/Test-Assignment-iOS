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
    /// Simple alert popup extension
    /// - Parameter title:          Alert title
    /// - Parameter message:        Alert message
    /// - Parameter buttons:        List of buttons for displaying
    public func showAlert(
        title: String? = nil,
        message: String,
        buttons: [UIAlertAction]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        buttons.forEach({ alert.addAction($0) })
        
        present(alert, animated: true, completion: nil)
    }
    
    /// Remove back button from native navigation bar
    func removeBackButtonTitle() {
        DispatchQueue.main.async {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(
                title: .empty, style: .plain, target: nil, action: nil
            )
        }
    }
}
