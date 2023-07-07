//
//  Card+CoreDataProperties.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//
//

import Foundation
import CoreData


@objc(Card)
public class Card: NSManagedObject {}

extension Card {
    static let numberRemovingCharactersCount = 10
}

// MARK: - Public Properties
public extension Card {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var number: String
    @NSManaged var expMonth: Int16
    @NSManaged var expYear: Int16
    @NSManaged var timestamp: Date
    @NSManaged var typeValue: Int16
    
    var type: CardType {
        set {
            self.typeValue = newValue.rawValue
        }
        get {
            return CardType(rawValue: self.typeValue) ?? .visa
        }
    }
    
    var formattedDetailsNumber: String? {
        get {
            formattedListNumber?.replaceCharacters(
                inRange: .init(location: .zero, length: Card.numberRemovingCharactersCount)
            )
        }
    }
}

// MARK: - Private Properties
private extension Card {
    var formattedListNumber: String? {
        get {
            try? number
                .masked(matching: "(?<=).(?=.{4})")
                .masked(matching: "(?<=.{4})(?=(?:.{4})+$)", with: String.space)
        }
    }
}

// MARK: - Internal Methods
extension Card {
    func createTVCModel() -> CardsTVCModel {
        return CardsTVCModel(
            type: type,
            number: formattedListNumber
        )
    }
}

extension Card : Identifiable {}
