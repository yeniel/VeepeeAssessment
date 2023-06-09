//
//  WindDto.swift
//  
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

/// DTO to decode OpenWeatherMap json objects
struct WindDto: Codable, Equatable {
    let speed: Double
    let directionDegrees: Int
    let gust: Double

    enum CodingKeys: String, CodingKey {
        case speed
        case directionDegrees = "deg"
        case gust
    }
}
