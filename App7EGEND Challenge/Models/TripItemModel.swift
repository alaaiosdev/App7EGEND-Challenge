//
//  TripObjModel.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import Foundation

struct TripItemModel: Codable {
    
    let name, date, imageURL: String?
    let description: TripDescriptionModel?
    
    enum CodingKeys: String, CodingKey {
        case name = "place-name"
        case imageURL = "image-url"
        case date, description
    }
}
