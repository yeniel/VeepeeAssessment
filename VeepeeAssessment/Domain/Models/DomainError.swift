//
//  VeepeeError.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

enum DomainError: Error, Equatable {
    case networkError
    case forecastNotFound
    case unknown
}
