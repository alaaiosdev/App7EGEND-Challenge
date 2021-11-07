//
//  TripDescriptionModel.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import Foundation

struct TripDescriptionModel: Codable {
    
    let title, description: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "description-trip"
    }
}
