//
//  NetworkProvider.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Combine
import Foundation

protocol NetworkProvider {
    func request<T: Decodable>(endpoint: String, responseType: T.Type) -> AnyPublisher<T, Error>
}
