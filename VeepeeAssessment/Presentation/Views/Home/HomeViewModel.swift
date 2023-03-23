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
    var forecastList: [ForecastUI] = []

    @Injected(\.getForecastListUseCase)
    private var getForecastListUseCase

    private let coordinator: MainCoordinatorProtocol

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    @MainActor
    func getForecastList() async {
        let result = await getForecastListUseCase.execute(
            city: DomainConstants.defaultCity,
            days: DomainConstants.defaultDays
        )

        switch result {
        case .success(let forecastList):
            self.forecastList = forecastList.map { domainModelToUIModel(domainModel: $0) }
            self.status = .loaded
        case .failure(let error):
            print(error)
            self.forecastList = []
            self.status = .failed("Error: Try again later")
        }
    }

    func routeToDetail(forecastDatetime: Date) {
        coordinator.routeToDetail(forecastDatetime: forecastDatetime)
    }

    private func domainModelToUIModel(domainModel: Forecast) -> ForecastUI {
        let datetime = domainModel.datetime.homeForecastFormat
        let minTemperature = domainModel.temperatureMin.temperatureFormat
        let maxTemperature = domainModel.temperatureMax.temperatureFormat
        let icon = ViewConstants.imagesUrl + domainModel.weather.icon + ViewConstants.imageType

        return ForecastUI(
            id: domainModel.datetime,
            datetime: datetime,
            minTemperature: minTemperature,
            maxTemperature: maxTemperature,
            icon: icon
        )
    }
}
