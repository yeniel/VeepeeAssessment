//
//  CurrentTimeZoneProvider.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 24/3/23.
//

import Foundation

struct CurrentTimeZoneProvider: TimeZoneProvider {
    var timeZone: TimeZone { TimeZone.current }
}
