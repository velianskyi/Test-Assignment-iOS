//
//  Module.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

protocol Transition { }

struct Module<T: Transition> {
    let transitionPublisher: Observable<T>
    let viewController: UIViewController
}
