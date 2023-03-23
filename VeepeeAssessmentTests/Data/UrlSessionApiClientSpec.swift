//
//  UrlSessionApiClientSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation
import Factory
import OHHTTPStubs
import OHHTTPStubsSwift
import Quick
import Nimble

// swiftlint:disable function_body_length

class UrlSessionApiClientSpec: QuickSpec {
    override func spec() {
        var forecastListDto: ForecastListDto?
        var requestError: ApiClientError?

        let url = "https://api.openweathermap.org/data/2.5/forecast?"
            + "q=Paris"
            + "&appid=588bc0d98fcd4e3cb6c8d6d44b089029"
            + "&units=metric"
            + "&lang=en"

        beforeEach {
            forecastListDto = nil
            requestError = nil
            setupStubs()
        }

        describe("GIVEN a UrlSessionApiClient") {
            context("WHEN request a forecast 5 days") {
                it("THEN returns a forecast list dto") {
                    let apiClient = UrlSessionApiClient()

                    forecastListDto = try? await apiClient.get(url: url)

                    await expect(forecastListDto).toEventually(equal(ObjectMother.forecastListDtoFromApi))
                }
            }

            context("WHEN request with wrong url") {
                it("THEN returns na ApiClientError.badUrl error") {
                    let apiClient = UrlSessionApiClient()

                    do {
                        forecastListDto = try await apiClient.get(url: "")
                    } catch let error {
                        requestError = error as? ApiClientError
                    }

                    await expect(forecastListDto).toEventually(beNil())
                    await expect(requestError).toEventually(equal(.badUrl))
                }
            }

            context("WHEN request and receive an error") {
                it("THEN returns a ApiClientError.requestError error") {
                    let notConnectedError = NSError(
                        domain: NSURLErrorDomain,
                        code: URLError.notConnectedToInternet.rawValue
                    )

                    setupStubs(error: notConnectedError)

                    let apiClient = UrlSessionApiClient()

                    do {
                        forecastListDto = try await apiClient.get(url: url)
                    } catch let error {
                        requestError = error as? ApiClientError
                    }

                    await expect(forecastListDto).toEventually(beNil())
                    await expect(requestError).toEventually(equal(.requestError))
                }
            }

            context("WHEN request and receive a status code diff than 200") {
                it("THEN returns a ApiClientError.statusNotOk error") {
                    setupStubs(statusCode: 400)

                    let apiClient = UrlSessionApiClient()

                    do {
                        forecastListDto = try await apiClient.get(url: url)
                    } catch let error {
                        requestError = error as? ApiClientError
                    }

                    await expect(forecastListDto).toEventually(beNil())
                    await expect(requestError).toEventually(equal(.statusNotOK))
                }
            }

            context("WHEN request and receive a wrong json") {
                it("THEN returns a ApiClientError.decodingError error") {
                    setupStubs(jsonFile: "wrong.json")

                    let apiClient = UrlSessionApiClient()

                    do {
                        forecastListDto = try await apiClient.get(url: url)
                    } catch let error {
                        requestError = error as? ApiClientError
                    }

                    await expect(forecastListDto).toEventually(beNil())
                    await expect(requestError).toEventually(equal(.decodingError))
                }
            }
        }

        func setupStubs(
            jsonFile: String? = "forecast.json",
            statusCode: Int32? = 200,
            error: NSError? = nil
        ) {
            stub(condition: isHost("api.openweathermap.org")
                 && isPath("/data/2.5/forecast")
                 && containsQueryParams(
                    [
                        "q": "Paris",
                        "appid": "588bc0d98fcd4e3cb6c8d6d44b089029",
                        "units": "metric",
                        "lang": "en"
                    ]
                 )
                 && isMethodGET()
            ) { _ in
                if let error = error {
                    return HTTPStubsResponse(error: error)
                }

                if let statusCode = statusCode, statusCode != 200 {
                    return HTTPStubsResponse(data: Data(), statusCode: statusCode, headers: nil)
                }

                let stubPath = OHPathForFile(jsonFile ?? "forecast.json", type(of: self))

                return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
            }
        }
    }
}

// swiftlint:enable function_body_length
