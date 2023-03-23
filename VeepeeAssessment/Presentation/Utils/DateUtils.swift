//
//  DateUtils.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

extension Date {
    var homeForecastFormat: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "E HH:mm"

        return dateFormatter.string(from: self).capitalized
    }

    var detailForecastFormat: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm, EEEE, MMM d"

        return dateFormatter.string(from: self).capitalized
    }
}
