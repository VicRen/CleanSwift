//
//  SplashViewModel.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/12.
//

// CleanSwift/Features/Splash/Presentation/ViewModels/SplashViewModel.swift
import Foundation
import Combine

enum SplashState {
    case idle
    case loading
    case ready
    case error(String)
}

enum SplashEvent {
    case start
    case loadDataFinished(LoadResult)
}

class SplashViewModel: ObservableObject {
    private let loadInitialDataUseCase: LoadInitialDataUseCase
    @Published private(set) var state: SplashState = .idle

    private var cancellables: Set<AnyCancellable> = []
    private let minDelaySeconds: Double = 1.0
    private let maxDelaySeconds: Double = 3.0
    let navigationEventPublisher = PassthroughSubject<NavigationEvent, Never>()

    init(loadInitialDataUseCase: LoadInitialDataUseCase) {
        self.loadInitialDataUseCase = loadInitialDataUseCase
        print("SplashViewModel init: \(self)")
    }

    func send(event: SplashEvent) {
        switch event {
        case .start:
            loadData()
        case .loadDataFinished(let result):
            switch result{
            case .success:
                print("------->loadDataFinished success")
                state = .ready
                navigationEventPublisher.send(.home)
            case .failure(let error):
                state = .error(error.localizedDescription)
                DispatchQueue.main.asyncAfter(deadline: .now() + maxDelaySeconds) {
                    self.navigationEventPublisher.send(.home)
                }
            }
        }
    }

    private func loadData() {
        state = .loading
        
        let timerPublisher = Timer.publish(every: minDelaySeconds, on: .main, in: .common)
            .autoconnect()
            .first()
            .map { _ in () }
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let dataPublisher = loadInitialDataUseCase.executeWork(input: ())
        Publishers.CombineLatest(timerPublisher, dataPublisher)
            .timeout(.seconds(maxDelaySeconds), scheduler: DispatchQueue.main, customError: { TimeoutError() })
            .first()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.send(event: .loadDataFinished(.failure(error)))
                }
            } receiveValue: { [weak self] (_,_) in
                guard let self = self else {return}
                self.send(event: .loadDataFinished(.success))
            }
            .store(in: &cancellables)
    }
}

struct TimeoutError: Error{}
