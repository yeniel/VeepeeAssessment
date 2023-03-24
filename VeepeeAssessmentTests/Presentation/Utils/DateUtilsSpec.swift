//
//  DateUtilsSpec.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 23/3/23.
//

import Foundation
import Quick
import Nimble
import Factory

class DateUtilsSpec: QuickSpec {
    override func spec() {
        describe("GIVEN the date 2023-03-22 18:00:00 +0000") {
            context("WHEN get home forecast format with Paris TimeZone") {
                it("THEN returns Wed 19:00") {
                    let date = ObjectMother.forecastFromApi.datetime
                    let dateUtils = DateUtils(timeZoneProvider: TestTimeZoneProvider())

                    let homeForecastFormat = dateUtils.homeForecastFormat(date: date)

                    expect(homeForecastFormat).to(equal("Wed 19:00"))
                }
            }

            context("WHEN get detail forecast format with Paris TimeZone") {
                it("THEN returns 19:00, Wednesday, Mar 22") {
                    let date = ObjectMother.forecastFromApi.datetime
                    let dateUtils = DateUtils(timeZoneProvider: TestTimeZoneProvider())

                    let homeForecastFormat = dateUtils.detailForecastFormat(date: date)

                    expect(homeForecastFormat).to(equal("19:00, Wednesday, Mar 22"))
                }
            }
        }
    }
}
