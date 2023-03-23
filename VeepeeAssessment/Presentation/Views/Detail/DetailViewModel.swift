//
//  DetailViewModel.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import Stinsen

class DetailViewModel: ObservableObject {
    @Published
    var status: ScreenStatus = .loading

    @Published
    var forecast: ForecastDetailUI = ForecastDetailUI()

    @Injected(\.getForecastUseCase)
    private var getForecastUseCase: GetForecastUseCase

    private let forecastDatetime: Date

    init(forecastDatetime: Date) {
        self.forecastDatetime = forecastDatetime
    }

    @MainActor
    func getForecast() async {
        let result = await getForecastUseCase.execute(
            forecastDatetime: forecastDatetime,
            city: ViewConstants.defaultCity,
            days: ViewConstants.defaultDays
        )

        switch result {
        case .success(let forecast):
            self.forecast = domainModelToUIModel(domainModel: forecast)
            self.status = .loaded
        case .failure(let error):
            print(error)
            self.forecast = ForecastDetailUI()
            self.status = .failed("Error: Try again later")
        }
    }

    private func domainModelToUIModel(domainModel: Forecast) -> ForecastDetailUI {
        let datetime = domainModel.datetime.detailForecastFormat
        let temperature = domainModel.temperature.temperatureFormat
        let temperatureMin = domainModel.temperatureMin.temperatureFormat
        let temperatureMax = domainModel.temperatureMax.temperatureFormat
        let feelsLike = domainModel.feelsLike.temperatureFormat
        let weatherIcon = ViewConstants.imagesUrl + domainModel.weather.icon + ViewConstants.imageType4x
        let weatherDescription = domainModel.weather.description.capitalized
        let pressure = domainModel.pressure.pressureFormat
        let humidity = domainModel.humidity.percentageFormat
        let wind = (domainModel.wind.speed * 3.6).windFormat
        let visibility = domainModel.visibility.visibilityFormat
        let precipitationProbability = (domainModel.precipitationProbability * 100).percentageFormat

        return ForecastDetailUI(
            datetime: datetime,
            temperature: temperature,
            temperatureMin: temperatureMin,
            temperatureMax: temperatureMax,
            feelsLike: feelsLike,
            weatherIcon: weatherIcon,
            weatherDescription: weatherDescription,
            pressure: pressure,
            humidity: humidity,
            wind: wind,
            visibility: visibility,
            precipitationProbability: precipitationProbability
        )
    }
}
