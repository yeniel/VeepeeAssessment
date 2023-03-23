//
//  ClockImpl.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation

/// Concrete implementation of `Clock` uses the system Date class
class ClockImpl: Clock {
    var now: Date {
        Date()
    }
}
