//
//  WeatherDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

/// DTO to decode OpenWeatherMap json objects
struct WeatherDto: Codable, Equatable {
    let id: Int
    let description: String
    let icon: String
}
