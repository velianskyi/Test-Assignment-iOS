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
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var number: String
    @NSManaged public var expMonth: Int16
    @NSManaged public var expYear: Int16
    @NSManaged public var timestamp: Date
    @NSManaged public var typeValue: Int16
    
    public var type: CardType {
        set {
            self.typeValue = newValue.rawValue
        }
        get {
            return CardType(rawValue: self.typeValue) ?? .visa
        }
    }
    
    func createTVCModel() -> CardsTVCModel {
        return CardsTVCModel(
            type: type,
            number: try? number
                .masked(matching: "(?<=).(?=.{4})")
                .masked(matching: "(?<=.{4})(?=(?:.{4})+$)", with: String.space)
        )
    }
}

extension Card : Identifiable {}
