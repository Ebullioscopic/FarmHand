//
//  Models.swift
//  FarmHandStorage
//
//  Created by admin63 on 17/09/24.
//

import Foundation

struct SensorData: Codable {
    var temperature: Double
    var humidity: Double
}

struct InferenceResult: Codable {
    var image_type: String
    var image_name: String
    var freshness: Int
    var shelf_life: String
    var shelf_life_unit: String
    var description: String

    private enum CodingKeys: String, CodingKey {
        case image_type
        case image_name
        case freshness
        case shelf_life
        case shelf_life_unit
        case description
    }
    
    // Custom initializer to handle the string-to-int conversion
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image_type = try container.decode(String.self, forKey: .image_type)
        image_name = try container.decode(String.self, forKey: .image_name)
        // Decode freshness as a string and then convert it to an integer
        let freshnessString = try container.decode(String.self, forKey: .freshness)
        freshness = Int(freshnessString) ?? 0
        shelf_life = try container.decode(String.self, forKey: .shelf_life)
        shelf_life_unit = try container.decode(String.self, forKey: .shelf_life_unit)
        description = try container.decode(String.self, forKey: .description)
    }
}
