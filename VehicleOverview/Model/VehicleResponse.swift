//
//  VehicleResponse.swift
//  VehicleOverview
//
//  Created by Sorbelli, Luciana Brenda on 18/06/2021.
//

import Foundation

struct Vehicle: Codable {
    let id: Int?
    let licensePlate, brand, model: String?
    let nickname: String?
    let lastPosition: LastPosition?

    enum CodingKeys: String, CodingKey {
        case id, licensePlate, brand, model, nickname
        case lastPosition = "last_position"
    }
    
}

// MARK: - LastPosition
struct LastPosition: Codable {
    let lat, lng: Double?
}

