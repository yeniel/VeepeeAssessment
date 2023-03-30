//
//  DtoMapper.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

/// Extension of `ForecastDto`   to map to domain models
extension ForecastDto {
    var model: Forecast {
        Forecast(
            datetime: Date(timeIntervalSince1970: self.datetime),
            temperature: self.main.temperature,
            feelsLike: self.main.feelsLike,
            temperatureMin: self.main.temperatureMin,
            temperatureMax: self.main.temperatureMax,
            pressure: self.main.pressure,
            humidity: self.main.humidity,
            weather: Weather(
                description: self.weather.first?.description ?? "",
                icon: self.weather.first?.icon ?? ""
            ),
            wind: Wind(
                speed: self.wind.speed,
                directionDegrees: self.wind.directionDegrees,
                gust: self.wind.gust
            ),
            visibility: self.visibility,
            precipitationProbability: self.precipitationProbability
        )
    }
}
