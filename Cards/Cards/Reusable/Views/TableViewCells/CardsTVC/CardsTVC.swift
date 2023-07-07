//
//  CardsTVC.swift
//  Cards
//
//  Created by Serhii Velianskyi on 07.07.2023.
//

import UIKit

class CardsTVC: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cardTypeImageView: UIImageView!
    @IBOutlet private weak var cardNumberLabel: UILabel!

    // MARK: - Public Methods
    
    func setup(with model: CardsTVCModel) {
        cardTypeImageView.image = model.type.image
        cardNumberLabel.text = model.number
    }
}
