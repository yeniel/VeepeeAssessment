//
//  GetForecastUseCase.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation
import Factory

protocol GetForecastUseCase {
    func execute(forecastDatetime: Date, city: String, days: Int) async -> Result<Forecast, DomainError>
}

struct GetForecastUseCaseImpl: GetForecastUseCase {
    @Injected(\.getForecastListUseCase)
    private var getForecastListUseCase

    func execute(
        forecastDatetime: Date,
        city: String = DomainConstants.defaultCity,
        days: Int = DomainConstants.defaultDays
    ) async -> Result<Forecast, DomainError> {
        let result = await getForecastListUseCase.execute(city: city, days: days)

        switch result {
        case .success(let forecastList):
            guard let forecast = forecastList.first(where: { $0.datetime == forecastDatetime }) else {
                return .failure(.unknown)
            }

            return .success(forecast)
        case .failure(let error):
            return .failure(error)
        }
    }
}
