//
//  Forecast.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct DayForecast {
    let datetime: Date
    let temperature: Double
    let feelsLike: Double
    let temperatureMin: Double
    let temperatureMax: Double
    let pressure: Int
    let seaLevel: Int
    let groundLevel: Int
    let humidity: Int
    let mainWeather: String
    let mainWeatherIcon: String
    let cloudiness: Int
    let windSpeed: Double
    let windDirectionDegrees: Int
    let windGust: Double
    let visibility: Int
    let precipitationProbability: Double
}
