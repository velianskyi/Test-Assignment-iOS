//
//  AppContainer.swift
//  Cards
//
//  Created by Serhii Velianskyi on 06.07.2023.
//

import CoreData

protocol AppContainer: AnyObject {
    var coreDataManager: CoreDataManager { get }
}

final class AppContainerImpl: AppContainer {
    let coreDataManager: CoreDataManager
    
    required init(appDelegate: AppDelegate) {
        self.coreDataManager = CoreDataManagerImpl(appDelegate: appDelegate)
    }
}
