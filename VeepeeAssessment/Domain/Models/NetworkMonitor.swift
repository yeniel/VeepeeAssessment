//
//  NetworkMonitor.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation

protocol NetworkMonitor {
    var isConnected: Bool { get }

    func start()
    func stop()
}
