//
//  UIColor.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

// MARK: - ColorAssetName
extension UIColor {
    enum ColorAssetName: String {
        
        // MARK: - CardType
        
        case visa
        case masterCard
    }
    
    static func color(_ assetName: ColorAssetName) -> UIColor {
        
        guard let color = UIColor(named: assetName.rawValue) else {
            print("Error: color \(assetName.rawValue) not found")
            return .red
        }
        
        return color
    }
}

// MARK: - Methods
public extension UIColor {
    func borderImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
