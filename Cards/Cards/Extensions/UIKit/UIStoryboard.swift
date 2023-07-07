//
//  UIStoryboard.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit

extension UIStoryboard {
    
    convenience init(name: StoryboardName) {
        self.init(name: name.rawValue, bundle: nil)
    }
    
    func instantiateVC<T: UIViewController>(identifier: String = T.identifier) -> T {
        let controller = self.instantiateViewController(withIdentifier: identifier) as! T
        controller.removeBackButtonTitle()
        return controller
    }
    
    func instantiateInitialVC() -> UIViewController {
        return self.instantiateInitialViewController()!
    }
}
