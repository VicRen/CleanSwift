//
//  ApiClient.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Foundation
import Combine

class ApiClient: NetworkProvider {
    
    func request<T: Decodable>(endpoint: String, responseType: T.Type) -> AnyPublisher<T, any Error> {
        Future<T, Error> { promise in
            guard let url = URL(string: endpoint) else {
                return
            }
        }
        .eraseToAnyPublisher()
    }
    
}
