//
//  ForecastRepositoryImpl.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Factory

/// Concrete implementatino of the `ForecastRepository`
struct ForecastRepositoryImpl: ForecastRepository {
    @Injected(\.forecastApiDataSource)
    private var apiDataSource: ForecastDataSource

    @Injected(\.forecastLocalDataSource)
    private var localDataSource: ForecastDataSource

    @Injected(\.clock)
    private var clock: Clock

    @Injected(\.userDefaults)
    private var userDefaults: UserDefaults

    @Injected(\.networkMonitor)
    var networkMonitor: NetworkMonitor

    private var isCacheExpired: Bool {
        let now = Int(clock.now.timeIntervalSince1970.rounded())
        let cacheDate = userDefaults.forecastCacheExpiry + ApiConstants.cacheExpiryInSeconds

        return cacheDate < now
    }

    func getForecast(city: String, days: Int) async throws -> [Forecast] {
        var dataSource: ForecastDataSource

        if isCacheExpired, networkMonitor.isConnected {
            dataSource = apiDataSource
        } else {
            dataSource = localDataSource
        }

        let forecastDtoList = try await dataSource.getForecastList(city: city, days: days)
        let forecastList = forecastDtoList.map { $0.model }

        if isCacheExpired {
            localDataSource.saveForecastList(forecastList: forecastDtoList)
            userDefaults.forecastCacheExpiry = Int(clock.now.timeIntervalSince1970)
        }

        return forecastList
    }
}
