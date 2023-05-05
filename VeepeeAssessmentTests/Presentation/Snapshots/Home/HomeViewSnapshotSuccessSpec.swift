//
//  HomeViewSnapshotSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Factory
import SnapshotTesting
import Quick
import Nimble
import Foundation

class HomeViewSnapshotSuccessSpec: QuickSpec {
    override func spec() {
        var mockCoordinator: MockMainCoordinator!

        isRecording = false

        beforeEach {
            Container.shared.manager.push()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a successfully HomeView") {
            context("WHEN get forecast list") {
                it("THEN snapshot should match") { @MainActor in
                    setupMocks()

                    let viewModel = HomeViewModel()
                    let view = HomeView(viewModel: viewModel, mainCoordinator: mockCoordinator)

                    await viewModel.getForecastList()

                    assertSnapshot(
                        matching: view,
                        as: .image(
                            layout: .fixed(width: 375, height: 667),
                            traits: .init(userInterfaceStyle: .light)
                        )
                    )
                }
            }
        }

        func setupMocks(error: DomainError? = nil) {
            mockCoordinator = MockMainCoordinator()

            Container.shared.getForecastListUseCase.register { MockGetForecastListUseCase(error: error)
            }

            Container.shared.dateUtils.register {
                DateUtils(timeZoneProvider: TestTimeZoneProvider())
            }
        }
    }
}
