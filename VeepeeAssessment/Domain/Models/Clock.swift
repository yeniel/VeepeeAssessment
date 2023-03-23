//
//  Clock.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation

/// This virtual clock is injected into classes that need a Date.now. It necesarry to do the Unit Tests
protocol Clock {
    var now: Date { get }
}
