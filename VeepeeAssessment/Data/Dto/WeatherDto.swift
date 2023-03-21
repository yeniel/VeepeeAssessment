//
//  WeatherDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct WeatherDto: Codable {
    let id: Int
    let description: String
    let icon: String
}
