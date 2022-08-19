//
//  userData.swift
//  Final_8813480
//
//  Created by Smit Mehta on 2022-08-17.
//

import Foundation

//Creating a Struct to get the values from the JSON file
struct WelcomeElement: Codable {
    let id, displayName: String
    let areas: [WelcomeElement]
    let totalConfirmed: Int
    let totalDeaths, totalRecovered, totalRecoveredDelta, totalDeathsDelta: Int?
    let totalConfirmedDelta: Int?
    let lastUpdated: LastUpdated?
    let lat, long: Double?
    let parentID: String?

    enum CodingKeys: String, CodingKey {
        case id, displayName, areas, totalConfirmed, totalDeaths, totalRecovered, totalRecoveredDelta, totalDeathsDelta, totalConfirmedDelta, lastUpdated, lat, long
        case parentID = "parentId"
    }
}

enum LastUpdated: String, Codable {
    case the20200413T025727092Z = "2020-04-13T02:57:27.092Z"
}

typealias Welcome = [WelcomeElement]
