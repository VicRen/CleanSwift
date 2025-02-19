//
//  SplashView.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/12.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack {
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    
                Text("CleanSwift")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                case .ready:
                    EmptyView()
                case .error(let message):
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            viewModel.send(event: .start)
        }
    }
}

#Preview {
}
