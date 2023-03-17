//
//  ForecastRepositoryImpl.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Factory

struct ForecastRepositoryImpl: ForecastRepository {
    @Injected(\.forecastApiDataSource)
    private var apiDataSource: ForecastDataSource

    @Injected(\.apiDtoMapper)
    private var dtoMapper: ApiDtoMapper

    func getForecast(city: String, days: Int) async throws -> [DayForecast] {
        try await apiDataSource.getForecast(city: city, days: days)
            .map { dtoMapper.dtoToModel(dto: $0) }
    }
}
