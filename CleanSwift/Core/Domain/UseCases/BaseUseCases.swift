//
//  BaseUseCases.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/12.
//

import Foundation
import Combine

protocol SynchronousUseCase {}

class BaseUseCase<Input, Output> {
    private var cancellables: Set<AnyCancellable> = []
    private(set) var lastError: Error?

    func execute(input: Input, scheduler: DispatchQueue? = nil, completion: @escaping (Result<Output, Error>) -> Void) {
        let executionScheduler = scheduler ?? DispatchQueue.global(qos: .userInitiated)

        var publisher = executeWork(input: input)

        if self is SynchronousUseCase {
            // 什么也不做
        } else {
            publisher = publisher
                .subscribe(on: executionScheduler)
                .eraseToAnyPublisher()
        }

        publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self.lastError = error
                    completion(.failure(error))
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else {return}
                completion(.success(value))
            })
            .store(in: &cancellables)
    }

    internal func executeWork(input: Input) -> AnyPublisher<Output, Error> {
        fatalError("Subclasses must implement `executeWork`")
    }

    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
