//
//  GetForecastListUseCase.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Factory

protocol GetForecastListUseCase {
    func execute(city: String, days: Int) async -> Result<[Forecast], DomainError>
}

struct GetForecastListUseCaseImpl: GetForecastListUseCase {
    @Injected(\.forecastRepository)
    private var forecastRepository

    func execute(
        city: String = DomainConstants.defaultCity,
        days: Int = DomainConstants.defaultDays
    ) async -> Result<[Forecast], DomainError> {
        do {
            let forecastList = try await forecastRepository.getForecast(city: city, days: days)

            return .success(forecastList)
        } catch let error {
            switch error {
            case ApiClientError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
