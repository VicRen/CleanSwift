//
//  HomeDataMapper.swift
//  CleanSwift
//
//  Created by Vic Ren on 2025/2/13.
//

struct HomeDataMapper {
    static func map(_ homeDataModel: HomeDataModel) -> HomeDescription {
        return HomeDescription(description: homeDataModel.description)
    }
}
