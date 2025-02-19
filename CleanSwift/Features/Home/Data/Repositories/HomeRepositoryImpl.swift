//
//  HomeRepositoryImpl.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Combine

class HomeRepositoryImpl: HomeRepository {
    private let localDataSource: HomeLocalDataSource
    
    init(localDataSource: HomeLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getHomeData() -> AnyPublisher<HomeDescription?, Error> {
        localDataSource.getHomeData()
            .map { homeDataModel -> HomeDescription? in
                guard let homeDataModel = homeDataModel else { return nil }
                return HomeDataMapper.map(homeDataModel)
            }
            .eraseToAnyPublisher()
    }
}
