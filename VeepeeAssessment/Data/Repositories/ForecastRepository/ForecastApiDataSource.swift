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

    func getForecast(city: String, days: Int) async throws -> [ForecastDto] {
        let cityQueryParam = "q=\(city)"
        let apiKeyQueryParam = "appid=\(ApiConstants.apiKey)"
        let unitsQueryParam = "units=metric"
        let languageQueryParam = "lang=\(Locale.current.language.languageCode?.identifier ?? "en")"

        let url = "\(ApiConstants.host)/\(ApiConstants.forecastPath)?"
            + "\(cityQueryParam)"
            + "&\(apiKeyQueryParam)"
            + "&\(unitsQueryParam)"
            + "&\(languageQueryParam)"

        let forecastDto: ForecastListDto = try await apiClient.get(url: url)

        return forecastDto.list
    }

}
