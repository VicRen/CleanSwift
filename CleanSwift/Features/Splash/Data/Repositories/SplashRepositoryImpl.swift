//
//  SplashRepositoryImpl.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Foundation
import Combine

class SplashRepositoryImpl: SplashRepository {
    
    private let remoteDataSource: SplashRemoteDataSource
    private let localDataSource: SplashLocalDataSource
    
    init(remoteDataSource: SplashRemoteDataSource, localDataSource: SplashLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func loadData() -> AnyPublisher<Void, Error> {
        remoteDataSource.loadData()
            .tryMap { splashDataModel -> Void in
                self.localDataSource.savaSplashData(splashDataModel)
                return ()
            }
            .eraseToAnyPublisher()
    }
}
