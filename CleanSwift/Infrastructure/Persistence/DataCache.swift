//
//  DataCache.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/18.
//

import Combine
import Foundation

protocol DataCache {
    var dataPublisher: AnyPublisher<Data?, Never> { get }
    func saveData(_ data: Data?)
}
