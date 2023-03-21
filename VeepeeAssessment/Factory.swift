//
//  Factory.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Factory

extension Container {
    // MARK: ApiClient

    var urlSessionApiClient: Factory<ApiClient> {
        Factory(self) { UrlSessionApiClient() }
    }

    // MARK: Repositories

    var forecastRepository: Factory<ForecastRepository> {
        Factory(self) { ForecastRepositoryImpl() }
    }

    var forecastApiDataSource: Factory<ForecastDataSource> {
        Factory(self) { ForecastApiDataSource() }
    }

    // MARK: Mappers

    var apiDtoMapper: Factory<ApiDtoMapper> {
        Factory(self) { ApiDtoMapper() }
    }

    var localDtoMapper: Factory<LocalDtoMapper> {
        Factory(self) { LocalDtoMapper() }
    }

    // MARK: Use Cases

    var getForecastListUseCase: Factory<GetForecastListUseCase> {
        Factory(self) { GetForecastListUseCaseImpl() }
    }

    var getForecastUseCase: Factory<GetForecastUseCase> {
        Factory(self) { GetForecastUseCaseImpl() }
    }
}
