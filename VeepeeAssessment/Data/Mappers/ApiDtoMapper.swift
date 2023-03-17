//
//  DtoMapper.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct ApiDtoMapper {
    func dtoToModel(dto: DayForecastDto) -> DayForecast {
        DayForecast(
            datetime: Date(timeIntervalSince1970: TimeInterval(dto.datetime)),
            temperature: dto.main.temperature,
            feelsLike: dto.main.feelsLike,
            temperatureMin: dto.main.temperatureMin,
            temperatureMax: dto.main.temperatureMax,
            pressure: dto.main.pressure,
            seaLevel: dto.main.seaLevel,
            groundLevel: dto.main.groundLevel,
            humidity: dto.main.humidity,
            weather: Weather(
                description: dto.weather.first?.description ?? "",
                icon: dto.weather.first?.icon ?? ""
            ),
            cloudiness: dto.clouds.cloudiness,
            wind: Wind(
                speed: dto.wind.speed,
                directionDegrees: dto.wind.directionDegrees,
                gust: dto.wind.gust
            ),
            visibility: dto.visibility,
            precipitationProbability: dto.precipitationProbability
        )
    }
}
