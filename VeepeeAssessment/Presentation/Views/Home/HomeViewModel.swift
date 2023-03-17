//
//  HomeViewModel.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import Stinsen

class HomeViewModel: ObservableObject {
    @Published
    var status: ScreenStatus = .loading

    private let coordinator: MainCoordinatorProtocol

    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    private func routeToDetail() {
        coordinator.routeToDetail()
    }
}
