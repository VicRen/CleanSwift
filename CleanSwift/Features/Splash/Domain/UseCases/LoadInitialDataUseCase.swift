//
//  LoadInitialDataUseCase.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/12.
//

import Combine

enum LoadResult {
    case success
    case failure(Error)
}

class LoadInitialDataUseCase: BaseUseCase<Void, LoadResult> {
    private let repository: SplashRepository
    
    init(repository: SplashRepository) {
             self.repository = repository
             super.init()
         }
    
    override func executeWork(input: Void) -> AnyPublisher<LoadResult, Error> {
        return repository.loadData()
            .map { _ in LoadResult.success }
            .catch { error in Just(LoadResult.failure(error)).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
    }
}
