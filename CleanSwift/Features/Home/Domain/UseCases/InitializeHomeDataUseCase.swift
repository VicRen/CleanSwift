//
//  InitializeHomeDataUseCase.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Combine
import Foundation

class InitializeHomeDataUseCase: BaseUseCase<Void, HomeDescription?> {
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
        super.init()
    }
    
    override func executeWork(input: Void) -> AnyPublisher<HomeDescription?, Error> {
        return repository.getHomeData()
            .eraseToAnyPublisher()
    }
}
