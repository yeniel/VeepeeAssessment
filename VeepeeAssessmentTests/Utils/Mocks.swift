//
//  Mocks.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation

// swiftlint:disable force_cast

final class MockApiClient<T>: ApiClient {
    var data: T
    var url: String?

    init(data: T) {
        self.data = data
    }

    func get<T: Decodable>(url: String) async throws -> T {
        self.url = url

        return data as! T
    }
}

final class MockMainCoordinator: MainCoordinatorProtocol {
    var routedToDetail = false

    func routeToDetail(forecastDatetime: Date) {
        routedToDetail = true
    }
}

final class MockNetworkMonitor: NetworkMonitor {
    var isConnectedValue: Bool

    var isConnected: Bool {
        isConnectedValue
    }

    init(isConnected: Bool = false) {
        self.isConnectedValue = isConnected
    }

    func start() {

    }

    func stop() {

    }
}

final class MockClock: Clock {
    var now: Date {
        Date(timeIntervalSince1970: timeIntervalSince1970)
    }

    let timeIntervalSince1970: TimeInterval

    init(timeIntervalSince1970: TimeInterval) {
        self.timeIntervalSince1970 = timeIntervalSince1970
    }
}

final class MockForecastApiDataSource: ForecastDataSource {
    func getForecastList(city: String, days: Int) async throws -> [ForecastDto] {
        ObjectMother.forecastListDtoFromApi.list
    }

    func saveForecastList(forecastList: [ForecastDto]) {

    }
}

final class MockForecastLocalDataSource: ForecastDataSource {
    var saveCalls: Int = 0

    func getForecastList(city: String, days: Int) async throws -> [ForecastDto] {
        ObjectMother.forecastListDtoFromLocal.list
    }

    func saveForecastList(forecastList: [ForecastDto]) {
        saveCalls += 1
    }
}

struct MockForecastRepository: ForecastRepository {
    var error: ApiClientError?

    init(error: ApiClientError?) {
        self.error = error
    }

    func getForecast(city: String, days: Int) async throws -> [Forecast] {
        if let error = error {
            throw error
        }

        return ObjectMother.forecastListFromApi
    }
}

struct MockGetForecastListUseCase: GetForecastListUseCase {
    var error: DomainError?

    init(error: DomainError? = nil) {
        self.error = error
    }

    func execute(city: String, days: Int) async -> Result<[Forecast], DomainError> {
        if let error = error {
            return .failure(error)
        }

        return .success(ObjectMother.forecastListFromApi)
    }
}

struct MockGetForecastUseCase: GetForecastUseCase {
    var error: DomainError?

    init(error: DomainError? = nil) {
        self.error = error
    }

    func execute(forecastDatetime: Date, city: String, days: Int) async -> Result<Forecast, DomainError> {
        if let error = error {
            return .failure(error)
        }

        return .success(ObjectMother.forecastFromApi)
    }
}
// swiftlint:enable force_cast
