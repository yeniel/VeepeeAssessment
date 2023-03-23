//
//  ScreenStatus.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

/// Define screen states
/// First the view is in **loading** state,
/// Then when data is received the state will change to **loaded**
/// If an error is received the state will change to **failed**
enum ScreenStatus: Equatable {
    case loading
    case loaded
    case failed(String)
}
