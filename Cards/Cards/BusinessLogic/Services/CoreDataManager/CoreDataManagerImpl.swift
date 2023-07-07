//
//  CoreDataManagerImpl.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import CoreData

final class CoreDataManagerImpl: CoreDataManager {
    
    // MARK: - Private Properties
    
    private var appDelegate: AppDelegate
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Initializers
    
    required init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
    }
}

// MARK: - Public Methods
extension CoreDataManagerImpl {
    public func createCard(name: String, number: String, expMonth: Int16, expYear: Int16, type: CardType) {
        guard let cardEntityDescription = NSEntityDescription.entity(forEntityName: "Card", in: context) else { return }
        
        let card = Card(entity: cardEntityDescription, insertInto: context)
        card.id = UUID()
        card.name = name
        card.number = number
        card.expMonth = expMonth
        card.expYear = expYear
        card.type = type
        card.timestamp = Date()
        
        appDelegate.saveContext()
    }
    
    public func fetchCards() -> Result<[Card]> {
        let fetchRequest = NSFetchRequest<Card>(entityName: "Card")
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Card.timestamp), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let cards = try context.fetch(fetchRequest)
            return .success(cards)
        } catch {
            return .error(ErrorsDict(error: error))
        }
    }
    
    func fetchCard(id: UUID) -> Result<Card> {
        let fetchRequest = NSFetchRequest<Card>(entityName: "Card")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let card = try context.fetch(fetchRequest)
            guard let card = card.first else { return .error(.init(errorMessage: "Card is nil"))}
            return .success(card)
        } catch {
            return .error(ErrorsDict(error: error))
        }
    }
    
    func deleteCards() -> Result<[Card]> {
        var result: Result<[Card]> = .success([])
        let fetchRequest = NSFetchRequest<Card>(entityName: "Card")
        do {
            let cards = try context.fetch(fetchRequest)
            cards.forEach { context.delete($0) }
        } catch {
            result = .error(ErrorsDict(error: error))
        }
        appDelegate.saveContext()
        return result
    }
}
