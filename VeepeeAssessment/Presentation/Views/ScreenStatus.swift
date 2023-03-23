//
//  ScreenStatus.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

enum ScreenStatus: Equatable {
    case loading
    case loaded
    case failed(DomainError)
}
