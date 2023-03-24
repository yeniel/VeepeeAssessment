//
//  DetailViewModelSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Factory
import Nimble
import Quick
import Stinsen

class DetailViewModelSpec: QuickSpec {
    override func spec() {
        var mockCoordinator: MockMainCoordinator!

        beforeEach {
            Container.shared.manager.push()
            setupMocks()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a DetailViewModel with successfully forecast use case") {
            context("WHEN get forecast") {
                it("THEN publishs forecast") { @MainActor in
                    let viewModel = DetailViewModel(forecastDatetime: ObjectMother.forecastFromApi.datetime)

                    await viewModel.getForecast()

                    await expect(viewModel.forecast).toEventually(equal(ObjectMother.forecastDetailUI))
                }

                it("THEN publishs loaded status") {
                    let viewModel = DetailViewModel(forecastDatetime: ObjectMother.forecastFromApi.datetime)

                    await viewModel.getForecast()

                    await expect(viewModel.status).toEventually(equal(.loaded))
                }
            }
        }

        describe("GIVEN a DetailViewModel with network error") {
            context("WHEN get forecast") {
                it("THEN publishs an empty forecast") {
                    setupMocks(error: .networkError)

                    let viewModel = DetailViewModel(forecastDatetime: ObjectMother.forecastFromApi.datetime)

                    await viewModel.getForecast()

                    await expect(viewModel.forecast).toEventually(equal(ForecastDetailUI()))
                }

                it("THEN publishs failed status with message 'Error: Try again later'") {
                    setupMocks(error: .networkError)

                    let viewModel = DetailViewModel(forecastDatetime: ObjectMother.forecastFromApi.datetime)

                    await viewModel.getForecast()

                    await expect(viewModel.status).toEventually(equal(.failed("Error: Try again later")))
                }
            }
        }

        func setupMocks(error: DomainError? = nil) {
            Container.shared.getForecastListUseCase.register { MockGetForecastListUseCase(error: error) }

            mockCoordinator = MockMainCoordinator()

            let mockNavigationRouter = NavigationRouter(
                id: 0,
                coordinator: mockCoordinator as MainCoordinatorProtocol
            )

            RouterStore.shared.store(router: mockNavigationRouter)

            Container.shared.dateUtils.register {
                DateUtils(timeZoneProvider: TestTimeZoneProvider())
            }
        }
    }
}
