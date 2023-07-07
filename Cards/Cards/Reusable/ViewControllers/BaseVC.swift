//
//  BaseVC.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit
import Combine

open class BaseVC: UIViewController {
    // MARK: - Public Properties
    public var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Private Properties
    private var errorTitlesFactory: TitlesFactory = .init()
    private var defaultErrorAlertButtonTitle: String = "OK"
}

// MARK: - Internal Methods
extension BaseVC {
    func handleErrors(errors: ErrorsDict) {
        guard let alertKey = errors.keys.sorted().last, let error = errors[alertKey] else { return }
        let title = errorTitlesFactory.title(for: alertKey)
        self.showAlert(title: title, message: error.localizedDescription)
    }
}

// MARK: - Public Methods
private extension BaseVC {
    func showAlert(title: String? = nil, error: Error) {
        showAlert(
            title: title,
            message: error.localizedDescription
        )
    }
    
    func showAlert(
        title: String? = nil,
        message: String,
        buttonTitle: String? = nil,
        action: ((UIAlertAction) -> Void)? = nil
    ) {
        showAlert(
            title: title,
            message: message,
            buttons: [
                UIAlertAction(
                    title: buttonTitle ?? defaultErrorAlertButtonTitle,
                    style: .default,
                    handler: action
                )
            ]
        )
    }
}

// MARK: - Models
extension BaseVC {
    struct TitlesFactory {
        func title(for key: String) -> String {
            ResponseKeyError(rawValue: key)?.title ?? key
        }
    }
}
