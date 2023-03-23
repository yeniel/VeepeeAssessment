//
//  NumberUtilsSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Quick
import Nimble

// swiftlint:disable function_body_length

class NumberUtilsSpec: QuickSpec {
    override func spec() {
        describe("GIVEN the temperature number 14.23") {
            context("WHEN get temperature format") {
                it("THEN returns 14°C") {
                    let temperature = 14.23

                    let temperatureFormat = temperature.temperatureFormat

                    expect(temperatureFormat).to(equal("14°C"))
                }
            }
        }

        describe("GIVEN the wind number 6.49") {
            context("WHEN get wind format") {
                it("THEN returns 6 km/h") {
                    let wind = 6.49

                    let windFormat = wind.windFormat

                    expect(windFormat).to(equal("6 km/h"))
                }
            }
        }

        describe("GIVEN the humidity number 74") {
            context("WHEN get percentage format") {
                it("THEN returns 74%") {
                    let humidity = 74

                    let percentageFormat = humidity.percentageFormat

                    expect(percentageFormat).to(equal("74%"))
                }
            }
        }

        describe("GIVEN the pressure number 1007") {
            context("WHEN get pressure format") {
                it("THEN returns 1.007 hPa") {
                    let pressure = 1007

                    let pressureFormat = pressure.pressureFormat

                    expect(pressureFormat).to(equal("1.007 hPa"))
                }
            }
        }

        describe("GIVEN the precipitation number 3.5") {
            context("WHEN get percentage format") {
                it("THEN returns 3.5%") {
                    let precipitation = 3.5

                    let percentageFormat = precipitation.percentageFormat

                    expect(percentageFormat).to(equal("3.5%"))
                }
            }
        }

        describe("GIVEN the visibility number 10000") {
            context("WHEN get visibility format") {
                it("THEN returns 10 km") {
                    let visibility = 10000

                    let visibilityFormat = visibility.visibilityFormat

                    expect(visibilityFormat).to(equal("10 km"))
                }
            }
        }
    }
}

// siwftlint:enable function_body_length
