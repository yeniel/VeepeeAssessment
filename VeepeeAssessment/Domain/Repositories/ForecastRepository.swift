//
//  ForecastRepository.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

protocol ForecastRepository {
    func getForecast(city: String, days: Int) async throws -> [DayForecast]
}
