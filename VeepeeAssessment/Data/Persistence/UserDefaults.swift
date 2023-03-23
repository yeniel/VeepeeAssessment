//
//  UserDefaults.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation

/// Property to save last cache expiry date
extension UserDefaults {
    var forecastCacheExpiry: Int {
        get {
            integer(forKey: "forecastCacheExpiry")
        }
        set {
            set(newValue, forKey: "forecastCacheExpiry")
        }
    }
}
