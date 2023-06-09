//
//  ForecastLocalDataSource.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation
import Factory
import CoreData

/// Concrete implementation of local data source to get data from `CoreData`
struct ForecastLocalDataSource: ForecastDataSource {
    @Injected(\.container)
    private var container: NSPersistentContainer

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    func getForecastList(city: String, days: Int) async throws -> [ForecastDto] {
        let cdForecastList = fetchForecastList()
        let forecastListDto = cdForecastList.compactMap { $0.dto(context: context) }

        return forecastListDto
    }

    func saveForecastList(forecastList: [ForecastDto]) {
        container.performBackgroundTask { context in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            forecastList.forEach { forecastDto in
                let forecastCD = ForecastCD(context: context)
                let mainCD = forecastDto.main.coreData(context: context)
                let weatherCD = forecastDto.weather.first?.coreData(context: context)
                let windCD = forecastDto.wind.coreData(context: context)

                forecastCD.datetime = forecastDto.datetime
                forecastCD.visibility = Int32(forecastDto.visibility)
                forecastCD.precipitationProbability = forecastDto.precipitationProbability
                forecastCD.main = mainCD
                forecastCD.wind = windCD

                if let weatherCD = weatherCD {
                    forecastCD.weather = weatherCD
                }

                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save Forecast in CoreData. \(error)")
                }
            }
        }
    }
}

extension ForecastLocalDataSource {
    private func fetchForecastList() -> [ForecastCD] {
        let request = ForecastCD.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching CoreData ForecastCD \(error)")
        }

        return []
    }
}
