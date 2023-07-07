//
//  CardType.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit

@objc
public enum CardType: Int16, CaseIterable {
    case visa
    case masterCard
    
    var image: UIImage? {
        switch self {
        case .visa: return UIImage(named: "icon_visa")
        case .masterCard: return UIImage(named: "icon_masterCard")
        }
    }
}
