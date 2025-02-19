//
//  InMemoryCacheDataSource.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Foundation
import Combine

class InMemoryCacheDataSource {
    private let dataCache: DataCache
    
    init(dataCache: DataCache) {
        self.dataCache = dataCache
    }
    
    func saveData(_ data: Data) {
        dataCache.saveData(data)
    }
    
    func getData() -> AnyPublisher<Data?, Never> {
        dataCache.dataPublisher.eraseToAnyPublisher()
    }
}

extension InMemoryCacheDataSource: SplashLocalDataSource {
    func savaSplashData(_ data: SplashDataModel) {
        saveData(data.data)
    }
}

extension InMemoryCacheDataSource: HomeLocalDataSource {
    func getHomeData() -> AnyPublisher<HomeDataModel?, Error> {
        Just(HomeDataModel(description: "Testing")).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
