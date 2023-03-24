//
//  DetailViewSnapshotSuccessSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Factory
import SnapshotTesting
import Quick
import Nimble
import Foundation

class DetailViewSnapshotSuccessSpec: QuickSpec {
    override func spec() {
        isRecording = true

        beforeEach {
            Container.shared.manager.push()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a successfully DetailView") {
            context("WHEN get forecast") {
                it("THEN snapshot should match") { @MainActor in
                    setupMocks()

                    let viewModel = DetailViewModel(forecastDatetime: ObjectMother.forecastFromApi.datetime)
                    let view = DetailView(viewModel: viewModel)

                    await viewModel.getForecast()

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
            Container.shared.getForecastUseCase.register { MockGetForecastUseCase(error: error)
            }

            Container.shared.dateUtils.register {
                DateUtils(timeZoneProvider: TestTimeZoneProvider())
            }
        }
    }
}
