//
//  CoreDataManager.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import CoreData

protocol CoreDataManager {
    func createCard(name: String, number: String, expMonth: Int16, expYear: Int16, type: CardType)
    func fetchCards() -> Result<[Card]>
    func fetchCard(id: UUID) -> Result<Card>
    func deleteCards() -> Result<[Card]>
}
