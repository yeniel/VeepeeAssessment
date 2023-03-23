//
//  ForecastDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

/// DTO to decode OpenWeatherMap json objects
struct ForecastListDto: Codable, Equatable {
    let list: [ForecastDto]
}
