//
//  NavigationPathStore.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/17.
//

import Combine

public class NavigationPathStore: ObservableObject {
    @Published public var path: [AppRoute] = []
    
    public init() {}
    
    public func append(_ element: AppRoute) {
        path.append(element)
        print("----->current path:\(path)")
    }
}
