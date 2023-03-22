//
//  ForecastDataSource.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

protocol ForecastDataSource {
    func getForecastList(city: String, days: Int) async throws -> [ForecastDto]
    func saveForecastList(forecastList: [ForecastDto])
}
