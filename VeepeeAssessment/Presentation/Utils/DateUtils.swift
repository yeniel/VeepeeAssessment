//
//  DateUtils.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

    var forecastFormat: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "E HH:mm"

        return dateFormatter.string(from: self)
    }
}