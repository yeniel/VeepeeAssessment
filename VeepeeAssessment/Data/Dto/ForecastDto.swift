//
//  ForecastDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct ForecastDto: Codable {
    let datetime: Double
    let main: ForecastMainDto
    let weather: [WeatherDto]
    let clouds: CloudsDto
    let wind: WindDto
    let visibility: Int
    let precipitationProbability: Double

    enum CodingKeys: String, CodingKey {
        case datetime = "dt"
        case main
        case weather
        case clouds
        case wind
        case visibility
        case precipitationProbability = "pop"
    }
}
