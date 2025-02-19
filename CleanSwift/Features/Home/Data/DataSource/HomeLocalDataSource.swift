//
//  HomeLocalDataSource.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Combine

protocol HomeLocalDataSource {
    func getHomeData() -> AnyPublisher<HomeDataModel?, Error>
}
