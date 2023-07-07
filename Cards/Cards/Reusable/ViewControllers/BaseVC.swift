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
}
