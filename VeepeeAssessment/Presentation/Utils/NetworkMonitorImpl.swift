//
//  NetworkMonitorImpl.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 22/3/23.
//

import Foundation
import Network

/// Concrete implementatino of `NetworkMonitor` used to check the connectiviy.
/// If the user is offline we will get data from persistent data source
final class NetworkMonitorImpl: ObservableObject, NetworkMonitor {
    @Published private(set) var isConnected = false

    private let nwMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue.global()

    public func start() {
        nwMonitor.start(queue: workerQueue)
        nwMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }

    public func stop() {
        nwMonitor.cancel()
    }
}
