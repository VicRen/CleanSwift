//
//  SplashRemoteDataSource.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Foundation
import Combine

protocol SplashRemoteDataSource {
    func loadData() -> AnyPublisher<SplashDataModel, Error>
}

