//
//  UserData.swift
//  MvvmSample
//
//  Created by M1086289 on 07/06/22.
//

import Foundation

// MARK: - UserData
struct UserData: Codable {
    let name: String
    let country: [Country]
}
// MARK: - Country
struct Country: Codable {
    let countryID: String
    let probability: Double

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case probability
    }
}
