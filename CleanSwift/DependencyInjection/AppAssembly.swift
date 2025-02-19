//
//  AppAssembly.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Swinject

class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ApiClient.self) { _ in ApiClient() }
            .inObjectScope(.container)
        container.register(DataCache.self) { _ in InMemoryCache.shared }
            .inObjectScope(.container)
        
        container.register(InMemoryCacheDataSource.self) { r in
            InMemoryCacheDataSource(dataCache: r.resolve(DataCache.self)!)
        }
        .inObjectScope(.container)
        
        container.register(SplashLocalDataSource.self) { r in
            r.resolve(InMemoryCacheDataSource.self)!
        }
        
        container.register(HomeLocalDataSource.self) { r in
            r.resolve(InMemoryCacheDataSource.self)!
        }
        
        container.register(NavigationPathStore.self) { r in
            NavigationPathStore()
        }.inObjectScope(.container)
        
        container.register(AppCoordinator.self) { r in
//            AppCoordinator(container: container, pathStore: r.resolve(NavigationPathStore.self)!)
            AppCoordinator(container: container)
        }
        .inObjectScope(.container)
    }
}
