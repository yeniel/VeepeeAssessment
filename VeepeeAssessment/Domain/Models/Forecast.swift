//
//  Forecast.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct Forecast {
    let datetime: Date
    let temperature: Double
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Int
    let humidity: Int
    let weather: Weather
    let wind: Wind
    let visibility: Int
    let precipitationProbability: Double
}
