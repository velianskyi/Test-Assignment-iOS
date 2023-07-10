//
//  AppDelegate.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public Properties
    
    var window: UIWindow?
    
    // MARK: - Private Properties
    
    private var appContainer: AppContainer!
    private var coordinator: CardsCoordinator?
    
    // MARK: - Lifecycle

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appContainer = AppContainerImpl(appDelegate: self)
        
        let navigationController = UINavigationController()
        coordinator = CardsCoordinator(navigationController: navigationController, appContainer: appContainer)
        coordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cards")
        container.loadPersistentStores { storeDescription, error in
            guard let error = error as NSError? else {
                print("Cards URL -", storeDescription.url?.absoluteString as Any)
                return
            }
            print("Unresolved error \(error), \(error.userInfo)")
        }
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

