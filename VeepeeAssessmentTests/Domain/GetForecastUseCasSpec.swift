//
//  GetForecastUseCasSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Quick
import Nimble
import Factory

class GetForecastUseCaseSpec: QuickSpec {
    override func spec() {
        var forecast: Result<Forecast, DomainError>?

        beforeEach {
            Container.shared.manager.push()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a successfully GetForecastUseCase") {
            context("WHEN execute it") {
                it("THEN returns a forecast") {
                    setupMocks()

                    let useCase = GetForecastUseCaseImpl()

                    forecast = await useCase.execute(
                        forecastDatetime: ObjectMother.forecastFromApi.datetime
                    )

                    await expect(forecast).toEventually(equal(.success(ObjectMother.forecastFromApi)))
                }
            }
        }

        describe("GIVEN a failed GetForecastListUseCase because of forecast is not in the repository") {
            context("WHEN execute it") {
                it("THEN returns a forecast not found domain error") {
                    setupMocks()

                    let useCase = GetForecastUseCaseImpl()

                    forecast = await useCase.execute(
                        forecastDatetime: Date(timeIntervalSince1970: TimeInterval(1679508002))
                    )

                    await expect(forecast).toEventually(equal(.failure(.forecastNotFound)))
                }
            }
        }

        describe("GIVEN a failed GetForecastListUseCase because of unknown error") {
            context("WHEN execute it") {
                it("THEN returns a domain unknown error") {
                    setupMocks(error: .statusNotOK)

                    let useCase = GetForecastUseCaseImpl()

                    forecast = await useCase.execute(
                        forecastDatetime: ObjectMother.forecastFromApi.datetime
                    )

                    await expect(forecast).toEventually(equal(.failure(.unknown)))
                }
            }
        }

        func setupMocks(error: ApiClientError? = nil) {
            Container.shared.forecastRepository.register { MockForecastRepository(error: error) }
        }
    }
}
