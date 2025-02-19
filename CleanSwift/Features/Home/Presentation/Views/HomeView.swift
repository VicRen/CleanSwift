//
//  HomeView.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        print("HomeView initialized")
    }

    var body: some View {
        Group{
            switch viewModel.state {
            case .idle:
                Text("Waiting for data...")
            case .loaded(let homeDescription):
                Text("Home Description: \(homeDescription.description)")
            case .error(let message):
                Text("Error: \(message)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            viewModel.loadData()
            print("HomeView appeared")
        }
        .navigationTitle("Home")
    }
}
