//
//  TripsModel.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import Foundation

struct TripsModel: Codable {
    let count: Int?
    let trips: [TripItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case count, trips
    }
}
