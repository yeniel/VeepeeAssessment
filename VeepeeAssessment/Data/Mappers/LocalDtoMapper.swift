//
//  LocalDtoMapper.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import CoreData
import Factory

/// Mapper to map `CoreData` models to domain models
struct LocalDtoMapper {
    @Injected(\.container)
    private var container: NSPersistentContainer

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    func coreDataToDto(entity: ForecastCD) -> ForecastDto? {
        guard let mainCD = fetchMainCD(forecast: entity) else {
            return nil
        }

        guard let weatherCD = fetchWeatherCD(forecast: entity) else {
            return nil
        }

        guard let windCD = fetchWindCD(forecast: entity) else {
            return nil
        }

        let mainDto = coreDataToDto(entity: mainCD)
        let weatherDto = coreDataToDto(entity: weatherCD)
        let windDto = coreDataToDto(entity: windCD)

        return ForecastDto(
            datetime: entity.datetime,
            main: mainDto,
            weather: [weatherDto],
            wind: windDto,
            visibility: Int(entity.visibility),
            precipitationProbability: entity.precipitationProbability
        )
    }

    private func coreDataToDto(entity: ForecastMainCD) -> ForecastMainDto {
        ForecastMainDto(
            temperature: entity.temperature,
            feelsLike: entity.feelsLike,
            temperatureMin: entity.temperatureMin,
            temperatureMax: entity.temperatureMax,
            pressure: Int(entity.pressure),
            humidity: Int(entity.humidity)
        )
    }

    private func coreDataToDto(entity: WeatherCD) -> WeatherDto {
        WeatherDto(id: 0, description: entity.descriptionString ?? "", icon: entity.icon ?? "")
    }

    private func coreDataToDto(entity: WindCD) -> WindDto {
        WindDto(speed: entity.speed, directionDegrees: Int(entity.directionDegrees), gust: entity.gust)
    }

    private func fetchMainCD(forecast: ForecastCD) -> ForecastMainCD? {
        let request = ForecastMainCD.fetchRequest()

        request.predicate = NSPredicate(format: "forecast = %@", forecast)

        do {
            if let mainCD = try context.fetch(request).first {
                return mainCD
            }
        } catch {
            print("Error fetching Core Data Forecast Main \(error)")
        }

        return nil
    }

    private func fetchWeatherCD(forecast: ForecastCD) -> WeatherCD? {
        let request = WeatherCD.fetchRequest()

        request.predicate = NSPredicate(format: "forecast = %@", forecast)

        do {
            if let weatherCD = try context.fetch(request).first {
                return weatherCD
            }
        } catch {
            print("Error fetching Core Data Weather \(error)")
        }

        return nil
    }

    private func fetchWindCD(forecast: ForecastCD) -> WindCD? {
        let request = WindCD.fetchRequest()

        request.predicate = NSPredicate(format: "forecast = %@", forecast)

        do {
            if let windCD = try context.fetch(request).first {
                return windCD
            }
        } catch {
            print("Error fetching Core Data Wind \(error)")
        }

        return nil
    }

    func dtoToCoreData(dto: ForecastMainDto, context: NSManagedObjectContext) -> ForecastMainCD {
        let mainCD = ForecastMainCD(context: context)

        mainCD.id = UUID()
        mainCD.feelsLike = dto.feelsLike
        mainCD.humidity = Int32(dto.humidity)
        mainCD.pressure = Int32(dto.pressure)
        mainCD.temperature = dto.temperature
        mainCD.temperatureMax = dto.temperatureMax
        mainCD.temperatureMin = dto.temperatureMin

        return mainCD
    }

    func dtoToCoreData(dto: WeatherDto?, context: NSManagedObjectContext) -> WeatherCD? {
        guard let dto = dto else {
            return nil
        }
        let weatherCD = WeatherCD(context: context)

        weatherCD.descriptionString = dto.description
        weatherCD.icon = dto.icon

        return weatherCD
    }

    func dtoToCoreData(dto: WindDto, context: NSManagedObjectContext) -> WindCD {
        let windCD = WindCD(context: context)

        windCD.id = UUID()
        windCD.speed = dto.speed
        windCD.directionDegrees = Int32(dto.directionDegrees)
        windCD.gust = dto.gust

        return windCD
    }
}
