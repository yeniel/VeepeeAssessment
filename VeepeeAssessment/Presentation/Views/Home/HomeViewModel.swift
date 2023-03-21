//
//  HomeViewModel.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import Stinsen

class HomeViewModel: ObservableObject {
    @Published
    var status: ScreenStatus = .loading

    @Published
    var forecast: [ForecastUI] = []

    @Injected(\.getForecastUseCase)
    private var getForecastUseCase

    private let coordinator: MainCoordinatorProtocol

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    @MainActor
    func getForecast() async {
        let result = await getForecastUseCase.execute(
            city: ViewConstants.defaultCity,
            days: ViewConstants.homeForecastDays
        )

        switch result {
        case .success(let forecast):
            self.forecast = forecast.map { domainModelToUIModel(domainModel: $0) }
            self.status = .loaded
        case .failure(let error):
            self.forecast = []
            self.status = .failed(error)
        }
    }

    private func domainModelToUIModel(domainModel: Forecast) -> ForecastUI {
        let datetime = domainModel.datetime.forecastFormat.capitalized
        let minTemperature = String(Int(domainModel.temperatureMin)) + "º"
        let maxTemperature = String(Int(domainModel.temperatureMax)) + "º"
        let icon = ViewConstants.imagesUrl + domainModel.weather.icon + ViewConstants.imageType

        return ForecastUI(
            id: UUID(),
            datetime: datetime,
            minTemperature: minTemperature,
            maxTemperature: maxTemperature,
            icon: icon
        )
    }

    private func routeToDetail() {
        coordinator.routeToDetail()
    }
}
