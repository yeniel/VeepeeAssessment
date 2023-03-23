//
//  HomeModel.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

struct ForecastUI: Identifiable, Equatable {
    var id: Date
    let datetime: String
    let minTemperature: String
    let maxTemperature: String
    let icon: String
}
