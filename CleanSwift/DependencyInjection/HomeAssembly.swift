//
//  HomeAssembly.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Swinject

class HomeAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(HomeRepository.self) { r in
            HomeRepositoryImpl(localDataSource: r.resolve(InMemoryCacheDataSource.self)!)
        }.inObjectScope(.transient)
        
        container.register(InitializeHomeDataUseCase.self) { r in
            InitializeHomeDataUseCase(repository: r.resolve(HomeRepository.self)!)
        }.inObjectScope(.transient)
        
        container.register(HomeViewModel.self) { r in
            HomeViewModel(intializeHomeDataUseCase: r.resolve(InitializeHomeDataUseCase.self)!)
        }.inObjectScope(.transient)
    }
}
