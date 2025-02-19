//
//  HomeRepository.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

import Combine

protocol HomeRepository {
    func getHomeData() -> AnyPublisher<HomeDescription?, Error>
}
