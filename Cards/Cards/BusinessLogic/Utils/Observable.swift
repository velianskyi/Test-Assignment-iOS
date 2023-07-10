//
//  Observable.swift
//  Cards
//
//  Created by Serhii Velianskyi on 10.07.2023.
//

import Foundation

class Observable<T> {
    
    // MARK: - Private Properties
    
    private(set) var value: T? {
        didSet {
            guard let value = value else { return }
            observer?(value)
        }
    }
    
    private var observer: ((T) -> ())?
    
    // MARK: - Public Methods
    public func bind(_ observer: @escaping (T) -> ()) {
        self.observer = observer
    }
    
    public func send(_ value: T) {
        self.value = value
    }
}
