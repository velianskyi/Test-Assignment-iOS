//
//  Module.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit
import Combine

protocol Transition { }

struct Module<T: Transition> {
    let transitionPublisher: AnyPublisher<T, Never>
    let viewController: UIViewController
}
