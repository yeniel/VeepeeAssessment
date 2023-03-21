//
//  GetForecastUseCase.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Factory

protocol GetForecastUseCase {
    func execute(city: String, days: Int) async -> Result<[Forecast], DomainError>
}

struct GetForecastUseCaseImpl: GetForecastUseCase {
    @Injected(\.forecastRepository)
    private var forecastRepository

    func execute(
        city: String = DomainConstants.defaultCity,
        days: Int = DomainConstants.defaultDays
    ) async -> Result<[Forecast], DomainError> {
        do {
            let dayForecastList = try await forecastRepository.getForecast(city: city, days: days)

            return .success(dayForecastList)
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
