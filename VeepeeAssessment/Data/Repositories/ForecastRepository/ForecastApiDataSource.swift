//
//  ForecastApiDataSource.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Factory

struct ForecastApiDataSource: ForecastDataSource {
    @Injected(\.urlSessionApiClient)
    private var apiClient: ApiClient

    func getForecast(city: String, days: Int) async throws -> [DayForecastDto] {
        let cityQueryParam = "q=\(city)"
        let apiKeyQueryParam = "appid=\(ApiConstants.apiKey)"
        let url = "\(ApiConstants.host)/\(ApiConstants.forecastPath)?\(cityQueryParam)&\(apiKeyQueryParam)"

        return try await apiClient.get(url: url)
    }

}
