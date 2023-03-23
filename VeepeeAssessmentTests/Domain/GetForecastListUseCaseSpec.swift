//
//  GetForecastListUseCaseSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Quick
import Nimble
import Factory

class GetForecastListUseCaseSpec: QuickSpec {
    override func spec() {
        var forecastList: Result<[Forecast], DomainError>?

        beforeEach {
            Container.shared.manager.push()
        }

        afterEach {
            Container.shared.manager.pop()
        }

        describe("GIVEN a successfully GetForecastListUseCase ") {
            context("WHEN execute it") {
                it("THEN returns a forecast list") {
                    setupMocks()

                    let useCase = GetForecastListUseCaseImpl()

                    forecastList = await useCase.execute()

                    await expect(forecastList).toEventually(equal(.success(ObjectMother.forecastListFromApi)))
                }
            }
        }

        describe("GIVEN a failed GetForecastListUseCase because of api request error ") {
            context("WHEN execute it") {
                it("THEN returns a network domain error") {
                    setupMocks(error: .requestError)

                    let useCase = GetForecastListUseCaseImpl()

                    forecastList = await useCase.execute()

                    await expect(forecastList).toEventually(equal(.failure(.networkError)))
                }
            }
        }

        describe("GIVEN a failed GetForecastListUseCase because of api error") {
            context("WHEN execute it") {
                it("THEN returns a unknown domain error") {
                    setupMocks(error: .statusNotOK)

                    let useCase = GetForecastListUseCaseImpl()

                    forecastList = await useCase.execute()

                    await expect(forecastList).toEventually(equal(.failure(.unknown)))
                }
            }
        }

        func setupMocks(error: ApiClientError? = nil) {
            Container.shared.forecastRepository.register { MockForecastRepository(error: error) }
        }
    }
}
