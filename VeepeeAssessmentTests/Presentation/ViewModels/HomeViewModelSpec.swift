//
//  HomeViewModelSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Factory
import Nimble
import Quick
import Stinsen

class HomeViewModelSpec: QuickSpec {
    override func spec() {
        var mockCoordinator: MockMainCoordinator!

        beforeEach {
            Container.shared.manager.push()
            setupMocks()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a HomeViewModel with successfully forecast list use case") {
            context("WHEN get forecast list") {
                it("THEN publishs forecast list") { @MainActor in
                    let viewModel = HomeViewModel()

                    await viewModel.getForecastList()

                    await expect(viewModel.forecastList).toEventually(equal(ObjectMother.forecastListUI))
                }
                it("THEN publishs loaded status") {
                    let viewModel = HomeViewModel()

                    await viewModel.getForecastList()

                    await expect(viewModel.status).toEventually(equal(.loaded))
                }
            }
        }

        describe("GIVEN a HomeViewModel with network error") {
            context("WHEN get forecast list") {
                it("THEN publishs an empty forecast list") {
                    setupMocks(error: .networkError)

                    let viewModel = HomeViewModel()

                    await viewModel.getForecastList()

                    await expect(viewModel.forecastList).toEventually(beEmpty())
                }

                it("THEN publishs failed status with message 'Error: Try again later'") {
                    setupMocks(error: .networkError)

                    let viewModel = HomeViewModel()

                    await viewModel.getForecastList()

                    await expect(viewModel.status).toEventually(equal(.failed("Error: Try again later")))
                }
            }
        }

        func setupMocks(error: DomainError? = nil) {
            Container.shared.getForecastListUseCase.register { MockGetForecastListUseCase(error: error) }

            mockCoordinator = MockMainCoordinator()

            let mockNavigationRouter = NavigationRouter(
                id: 0,
                coordinator: mockCoordinator as MainCoordinator
            )

            RouterStore.shared.store(router: mockNavigationRouter)

            Container.shared.dateUtils.register {
                DateUtils(timeZoneProvider: TestTimeZoneProvider())
            }
        }
    }
}
