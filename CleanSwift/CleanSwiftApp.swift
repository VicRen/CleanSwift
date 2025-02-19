//
//  CleanSwiftApp.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/12.
//

import SwiftUI
import Swinject

@main
struct CleanSwiftApp: App {
    let container = Container()
    private var assember: Assembler
    @ObservedObject private var coordinator: AppCoordinator
    
    init() {
        assember = Assembler([
            AppAssembly(),
            SplashAssembly(),
            HomeAssembly(),
        ], container: container)
        coordinator = assember.resolver.resolve(AppCoordinator.self)!
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.start()
            }
        }
    }
}
