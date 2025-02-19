//
//  SplashRemoteDataSourceImpl.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/14.
//

import Combine
import Foundation

class SplashRemoteDataSourceImpl: SplashRemoteDataSource {
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func loadData() -> AnyPublisher<SplashDataModel, Error> {
        return Deferred {
            Future<SplashDataModel, Error> { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    let defaultData = SplashDataModel(data: Data())
                    promise(.success(defaultData))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
