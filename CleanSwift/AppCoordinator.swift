//
//  AppCoordinator.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import SwiftUI
import Combine
import Swinject

class AppCoordinator: ObservableObject {
    private var container: Container
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var path = NavigationPath()
    
    init(container: Container) {
        self.container = container
        setupBindings()
    }
    
    func start() -> some View {
        rawSplashView()
            .navigationDestination(for: String.self) { rawValue in
                switch AppRoute(rawValue: rawValue) {
                case .home:
                    self.homeView()
                case .none:
                    EmptyView()
                }
            }
    }
    
    private func setupBindings() {
        guard let splashViewModel = container.resolve(SplashViewModel.self) else {
            print("Error: SplashViewModel not found")
            return
        }
        splashViewModel.navigationEventPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                self?.handleNavigationEvent(event)
            }
            .store(in: &cancellables)
    }
    
    private func handleNavigationEvent(_ event: NavigationEvent) {
        switch event {
        case .home:
            path.append(AppRoute.home.rawValue)
        }
    }
    
    private func rawSplashView() -> some View {
        return SplashView(viewModel: container.resolve(SplashViewModel.self)!)
    }
    
    private func homeView() -> some View {
        print("AppCoordinator: Creating HomeView")
        let homeViewModel = container.resolve(HomeViewModel.self)!
        return HomeView(viewModel: homeViewModel)
    }
}
