//
//  ForecastRepositorySpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Factory
import Foundation
import Quick
import Nimble

// swiftlint:disable function_body_length

class ForecastRepositorySpec: QuickSpec {
    override func spec() {
        var forecastList: [Forecast]?
        var mockForecastLocalDataSource: MockForecastLocalDataSource!
        var mockUserDefaults: UserDefaults!

        beforeEach {
            Container.shared.manager.push()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a ForecastRepository with no cache and network is connected") {
            context("WHEN gets forecast") {
                it("THEN returns a forecast list from api") {
                    setupMocks(clockTime: 11000, isConnected: true, forecastCacheExpiry: nil)

                    let repository = ForecastRepositoryImpl()

                    forecastList = try await repository.getForecast(city: "Paris", days: 5)

                    await expect(forecastList).toEventually(equal(ObjectMother.forecastListFromApi))
                }

                it("THEN saves a forecast list in local") {
                    setupMocks(clockTime: 11000, isConnected: true, forecastCacheExpiry: nil)

                    let repository = ForecastRepositoryImpl()

                    forecastList = try await repository.getForecast(city: "Paris", days: 5)

                    await expect(mockForecastLocalDataSource?.saveCalls).toEventually(equal(1))
                }

                it("THEN update forecast cache expiry") {
                    setupMocks(clockTime: 11000, isConnected: true, forecastCacheExpiry: nil)

                    let repository = ForecastRepositoryImpl()

                    forecastList = try await repository.getForecast(city: "Paris", days: 5)

                    await expect(mockUserDefaults?.forecastCacheExpiry).toEventually(equal(11000))
                }
            }
        }

        describe("GIVEN a ForecastRepository with cache") {
            context("WHEN gets forecast") {
                it("THEN returns a forecast list from local") {
                    setupMocks(clockTime: 11000, isConnected: true, forecastCacheExpiry: 11000)

                    let repository = ForecastRepositoryImpl()

                    forecastList = try await repository.getForecast(city: "Paris", days: 5)

                    await expect(forecastList).toEventually(equal(ObjectMother.forecastListFromLocal))
                }
            }
        }

        describe("GIVEN a ForecastRepository if is not connected") {
            context("WHEN gets forecast") {
                it("THEN returns a forecast list from local") {
                    setupMocks(clockTime: 11000, isConnected: true, forecastCacheExpiry: 11000)

                    let repository = ForecastRepositoryImpl()

                    forecastList = try await repository.getForecast(city: "Paris", days: 5)

                    await expect(forecastList).toEventually(equal(ObjectMother.forecastListFromLocal))
                }
            }
        }

        func setupMocks(clockTime: Int = 11000, isConnected: Bool = true, forecastCacheExpiry: Int? = nil) {
            mockForecastLocalDataSource = MockForecastLocalDataSource()

            Container.shared.urlSessionApiClient.register {
                MockApiClient<ForecastListDto>(data: ObjectMother.forecastListDtoFromApi)
            }

            Container.shared.forecastApiDataSource.register { MockForecastApiDataSource() }
            Container.shared.forecastLocalDataSource.register { mockForecastLocalDataSource }
            Container.shared.clock.register { MockClock(timeIntervalSince1970: TimeInterval(clockTime)) }
            Container.shared.networkMonitor.register { MockNetworkMonitor(isConnected: isConnected) }
            Container.shared.userDefaults.register {
                mockUserDefaults = UserDefaults(suiteName: #file)

                mockUserDefaults.removePersistentDomain(forName: #file)

                if let forecastCacheExpiry = forecastCacheExpiry {
                    mockUserDefaults.forecastCacheExpiry = forecastCacheExpiry
                }

                return mockUserDefaults
            }
        }
    }
}

// swiftlint:enable function_body_length
