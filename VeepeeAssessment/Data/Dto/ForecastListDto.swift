//
//  ForecastDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 21/3/23.
//

import Foundation

struct ForecastListDto: Codable, Equatable {
    let list: [ForecastDto]
}
