//
//  InMemoryCache.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Combine
import Foundation

class InMemoryCache: DataCache {
    static let shared = InMemoryCache()
    
    var dataPublisher: AnyPublisher<Data?, Never>
    
    private var dataSubject = CurrentValueSubject<Data?, Never>(nil)
    
    init() {
        dataPublisher = dataSubject.eraseToAnyPublisher()
    }
    
    func saveData(_ data: Data?) {
        dataSubject.send(data)
    }
}
