//
//  ObjectMother.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation

struct ObjectMother {
    static var forecastListDtoFromApi: ForecastListDto {
        ForecastListDto(list: [
            ForecastDto(
                datetime: 1679508000,
                main: ForecastMainDto(
                    temperature: 14.23,
                    feelsLike: 13.64,
                    temperatureMin: 12.66,
                    temperatureMax: 14.23,
                    pressure: 1007,
                    humidity: 74
                ),
                weather: [
                    WeatherDto(id: 803, description: "broken clouds", icon: "04d")
                ],
                wind: WindDto(speed: 6.49, directionDegrees: 208, gust: 13.59),
                visibility: 10000,
                precipitationProbability: 0.03
            ),
            ForecastDto(
                datetime: 1679518800,
                main: ForecastMainDto(
                    temperature: 13.61,
                    feelsLike: 13.04,
                    temperatureMin: 12.37,
                    temperatureMax: 13.61,
                    pressure: 1007,
                    humidity: 77
                ),
                weather: [
                    WeatherDto(id: 500, description: "light rain", icon: "10n")
                ],
                wind: WindDto(speed: 6.71, directionDegrees: 211, gust: 14.2),
                visibility: 10000,
                precipitationProbability: 0.64
            )
        ])
    }

    static var forecastListDtoFromLocal: ForecastListDto {
        ForecastListDto(list: [
            ForecastDto(
                datetime: 1679508001,
                main: ForecastMainDto(
                    temperature: 14.23,
                    feelsLike: 13.64,
                    temperatureMin: 12.66,
                    temperatureMax: 14.23,
                    pressure: 1007,
                    humidity: 74
                ),
                weather: [
                    WeatherDto(id: 803, description: "broken clouds", icon: "04d")
                ],
                wind: WindDto(speed: 6.49, directionDegrees: 208, gust: 13.59),
                visibility: 10000,
                precipitationProbability: 0.03
            ),
            ForecastDto(
                datetime: 1679518801,
                main: ForecastMainDto(
                    temperature: 13.61,
                    feelsLike: 13.04,
                    temperatureMin: 12.37,
                    temperatureMax: 13.61,
                    pressure: 1007,
                    humidity: 77
                ),
                weather: [
                    WeatherDto(id: 500, description: "light rain", icon: "10n")
                ],
                wind: WindDto(speed: 6.71, directionDegrees: 211, gust: 14.2),
                visibility: 10000,
                precipitationProbability: 0.64
            )
        ])
    }

    static var forecastListFromApi: [Forecast] {
        [
            Forecast(
                datetime: Date(timeIntervalSince1970: 1679508000),
                temperature: 14.23,
                feelsLike: 13.64,
                temperatureMin: 12.66,
                temperatureMax: 14.23,
                pressure: 1007,
                humidity: 74,
                weather: Weather(description: "broken clouds", icon: "04d"),
                wind: Wind(speed: 6.49, directionDegrees: 208, gust: 13.59),
                visibility: 10000,
                precipitationProbability: 0.03
            ),
            Forecast(
                datetime: Date(timeIntervalSince1970: 1679518800),
                temperature: 13.61,
                feelsLike: 13.04,
                temperatureMin: 12.37,
                temperatureMax: 13.61,
                pressure: 1007,
                humidity: 77,
                weather: Weather(description: "light rain", icon: "10n"),
                wind: Wind(speed: 6.71, directionDegrees: 211, gust: 14.2),
                visibility: 10000,
                precipitationProbability: 0.64
            )
        ]
    }

    static var forecastListFromLocal: [Forecast] {
        [
            Forecast(
                datetime: Date(timeIntervalSince1970: 1679508001),
                temperature: 14.23,
                feelsLike: 13.64,
                temperatureMin: 12.66,
                temperatureMax: 14.23,
                pressure: 1007,
                humidity: 74,
                weather: Weather(description: "broken clouds", icon: "04d"),
                wind: Wind(speed: 6.49, directionDegrees: 208, gust: 13.59),
                visibility: 10000,
                precipitationProbability: 0.03
            ),
            Forecast(
                datetime: Date(timeIntervalSince1970: 1679518801),
                temperature: 13.61,
                feelsLike: 13.04,
                temperatureMin: 12.37,
                temperatureMax: 13.61,
                pressure: 1007,
                humidity: 77,
                weather: Weather(description: "light rain", icon: "10n"),
                wind: Wind(speed: 6.71, directionDegrees: 211, gust: 14.2),
                visibility: 10000,
                precipitationProbability: 0.64
            )
        ]
    }
}
