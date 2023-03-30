//
//  LocalDtoMapper.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import CoreData
import Factory

/// Mappers of `CoreData` models to domain models

extension ForecastCD {
    func dto(context: NSManagedObjectContext) -> ForecastDto? {
        guard let mainCD = fetchMainCD(context: context) else {
            return nil
        }

        guard let weatherCD = fetchWeatherCD(context: context) else {
            return nil
        }

        guard let windCD = fetchWindCD(context: context) else {
            return nil
        }

        return ForecastDto(
            datetime: self.datetime,
            main: mainCD.dto,
            weather: [weatherCD.dto],
            wind: windCD.dto,
            visibility: Int(self.visibility),
            precipitationProbability: self.precipitationProbability
        )
    }

    private func fetchMainCD(context: NSManagedObjectContext) -> ForecastMainCD? {
        let request = ForecastMainCD.fetchRequest()

        request.predicate = NSPredicate(format: "forecast = %@", self)

        do {
            if let mainCD = try context.fetch(request).first {
                return mainCD
            }
        } catch {
            print("Error fetching Core Data Forecast Main \(error)")
        }

        return nil
    }

    private func fetchWeatherCD(context: NSManagedObjectContext) -> WeatherCD? {
        let request = WeatherCD.fetchRequest()

        request.predicate = NSPredicate(format: "forecast = %@", self)

        do {
            if let weatherCD = try context.fetch(request).first {
                return weatherCD
            }
        } catch {
            print("Error fetching Core Data Weather \(error)")
        }

        return nil
    }

    private func fetchWindCD(context: NSManagedObjectContext) -> WindCD? {
        let request = WindCD.fetchRequest()

        request.predicate = NSPredicate(format: "forecast = %@", self)

        do {
            if let windCD = try context.fetch(request).first {
                return windCD
            }
        } catch {
            print("Error fetching Core Data Wind \(error)")
        }

        return nil
    }
}

extension ForecastMainCD {
    var dto: ForecastMainDto {
        ForecastMainDto(
            temperature: self.temperature,
            feelsLike: self.feelsLike,
            temperatureMin: self.temperatureMin,
            temperatureMax: self.temperatureMax,
            pressure: Int(self.pressure),
            humidity: Int(self.humidity)
        )
    }
}

extension WeatherCD {
    var dto: WeatherDto {
        WeatherDto(id: 0, description: self.descriptionString ?? "", icon: self.icon ?? "")
    }
}

extension WindCD {
    var dto: WindDto {
        WindDto(speed: self.speed, directionDegrees: Int(self.directionDegrees), gust: self.gust)
    }
}

extension ForecastMainDto {
    func coreData(context: NSManagedObjectContext) -> ForecastMainCD {
        let mainCD = ForecastMainCD(context: context)

        mainCD.id = UUID()
        mainCD.feelsLike = self.feelsLike
        mainCD.humidity = Int32(self.humidity)
        mainCD.pressure = Int32(self.pressure)
        mainCD.temperature = self.temperature
        mainCD.temperatureMax = self.temperatureMax
        mainCD.temperatureMin = self.temperatureMin

        return mainCD
    }
}

extension WeatherDto {
    func coreData(context: NSManagedObjectContext) -> WeatherCD {
        let weatherCD = WeatherCD(context: context)

        weatherCD.descriptionString = self.description
        weatherCD.icon = self.icon

        return weatherCD
    }
}

extension WindDto {
    func coreData(context: NSManagedObjectContext) -> WindCD {
        let windCD = WindCD(context: context)

        windCD.id = UUID()
        windCD.speed = self.speed
        windCD.directionDegrees = Int32(self.directionDegrees)
        windCD.gust = self.gust

        return windCD
    }
}
