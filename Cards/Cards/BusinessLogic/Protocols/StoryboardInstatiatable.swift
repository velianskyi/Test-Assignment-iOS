//
//  StoryboardInstatiatable.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit

protocol StoryboardInstatiatable {
    static var storyboardName: StoryboardName { get }
}

extension StoryboardInstatiatable where Self: UIViewController {
    
    static func instantiateVC() -> Self {
        let viewController: Self = UIStoryboard(name: storyboardName).instantiateVC() as Self
        
        return viewController
    }
}
