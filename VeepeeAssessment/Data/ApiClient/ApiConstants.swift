//
//  ApiConstants.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

enum ApiConstants {
    static let host = "https://api.openweathermap.org"
    static let apiKey = "588bc0d98fcd4e3cb6c8d6d44b089029"
    static let forecastPath = "data/2.5/forecast"
    static let cacheExpiryInSeconds = 60 * 60 * 3
}
