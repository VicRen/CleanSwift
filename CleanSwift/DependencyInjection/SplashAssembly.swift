//
//  SplashAssembly.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Swinject

class SplashAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(SplashRemoteDataSource.self) { r in
            SplashRemoteDataSourceImpl(networkProvider: r.resolve(ApiClient.self)!)
        }.inObjectScope(.transient)
        
        container.register(SplashRepository.self) { r in
            SplashRepositoryImpl(remoteDataSource: r.resolve(SplashRemoteDataSource.self)!,
                                 localDataSource: r.resolve(InMemoryCacheDataSource.self)!)
        }.inObjectScope(.transient)
        
        container.register(LoadInitialDataUseCase.self) { r in
            LoadInitialDataUseCase(repository: r.resolve(SplashRepository.self)!)
        }.inObjectScope(.transient)
        
        container.register(SplashViewModel.self) { r in
            SplashViewModel(loadInitialDataUseCase: r.resolve(LoadInitialDataUseCase.self)!)
        }.inObjectScope(.container)
    }
}
