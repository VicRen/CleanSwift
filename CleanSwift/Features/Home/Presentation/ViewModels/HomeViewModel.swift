//
//  HomeViewModel.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Foundation
import Combine

enum HomeState {
    case idle
    case loaded(HomeDescription)
    case error(String)
}

class HomeViewModel: ObservableObject {
    @Published private(set) var state: HomeState = .idle
    private var cancellables: Set<AnyCancellable> = []
    private let intializeHomeDataUseCase: InitializeHomeDataUseCase
    
    init(intializeHomeDataUseCase: InitializeHomeDataUseCase) {
        self.intializeHomeDataUseCase = intializeHomeDataUseCase
    }
    
    func loadData() {
        intializeHomeDataUseCase.execute(input: ()) { [weak self] reslut in
            switch reslut {
            case .success(let homeDescription):
                if let description = homeDescription {
                    self?.state = .loaded(description)
                } else {
                    self?.state = .error("No data found")
                }
            case .failure(let error):
                self?.state = .error(error.localizedDescription)
            }
        }
    }
}
