//
//  DayForecastMainDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct DayForecastMainDto: Codable {
    let temperature: Double
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Int
    let seaLevel: Int
    let groundLevel: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
        case humidity = "humidity"
    }
}
