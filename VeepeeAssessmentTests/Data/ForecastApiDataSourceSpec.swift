//
//  ForecastApiDataSourceSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Factory
import Quick
import Nimble

class ForecastApiDataSourceSpec: QuickSpec {
    override func spec() {
        var mockApiClient: MockApiClient<ForecastListDto>!
        let url = "https://api.openweathermap.org/data/2.5/forecast?"
            + "q=London"
            + "&appid=588bc0d98fcd4e3cb6c8d6d44b089029"
            + "&units=metric"
            + "&lang=en"

        beforeEach {
            Container.shared.manager.push()
            setupMocks()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a ForecastApiDataSource") {
            context("WHEN gets forecast") {
                it("THEN returns forecast list dto") {
                    let dataSource = ForecastApiDataSource()

                    let forecastListDto = try await dataSource.getForecastList(city: "London", days: 3)

                    await expect(forecastListDto).toEventually(equal(ObjectMother.forecastListDtoFromApi.list))
                }

                it("THEN url should be \(url)") {
                    let dataSource = ForecastApiDataSource()

                    _ = try await dataSource.getForecastList(city: "London", days: 3)

                    await expect(mockApiClient.url).toEventually(equal(url))
                }
            }
        }

        func setupMocks() {
            mockApiClient = MockApiClient<ForecastListDto>(data: ObjectMother.forecastListDtoFromApi)

            Container.shared.urlSessionApiClient.register { mockApiClient }
        }
    }
}
