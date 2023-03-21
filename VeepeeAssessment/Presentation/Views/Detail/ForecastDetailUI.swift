//
//  ForecastDetailUI.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

struct ForecastDetailUI {
    let datetime: String
    let temperature: String
    let temperatureMin: String
    let temperatureMax: String
    let feelsLike: String
    let weatherIcon: String
    let weatherDescription: String
    let pressure: String
    let humidity: String
    let wind: String
    let visibility: String
    let precipitationProbability: String
}

extension ForecastDetailUI {
    init() {
        self.init(
            datetime: "",
            temperature: "",
            temperatureMin: "",
            temperatureMax: "",
            feelsLike: "",
            weatherIcon: "",
            weatherDescription: "",
            pressure: "",
            humidity: "",
            wind: "",
            visibility: "",
            precipitationProbability: ""
        )
    }
}
