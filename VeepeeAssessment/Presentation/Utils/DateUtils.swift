//
//  DateUtils.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

struct DateUtils {
    let timeZoneProvider: TimeZoneProvider

    func homeForecastFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "E HH:mm"
        dateFormatter.timeZone = timeZoneProvider.timeZone

        return dateFormatter.string(from: date).capitalized
    }

    func detailForecastFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm, EEEE, MMM d"
        dateFormatter.timeZone = timeZoneProvider.timeZone

        return dateFormatter.string(from: date).capitalized
    }
}
