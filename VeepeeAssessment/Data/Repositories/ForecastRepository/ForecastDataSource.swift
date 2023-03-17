//
//  ForecastDataSource.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

protocol ForecastDataSource {
    func getForecast(city: String, days: Int) async throws -> [DayForecastDto]
}
