//
//  MainCoordinator.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Stinsen
import SwiftUI

protocol MainCoordinatorProtocol {
    func routeToDetail(forecastDatetime: Date)
}

final class MainCoordinator: MainCoordinatorProtocol, NavigationCoordinatable {
    let stack = NavigationStack(initial: \MainCoordinator.start)

    lazy var routerStorable: MainCoordinator = self

    @Root
    var start = makeStart

    @Route(.push)
    var detailView = makeDetailView

    @ViewBuilder
    func makeStart() -> some View {
        let viewModel = HomeViewModel(coordinator: self)

        HomeView(viewModel: viewModel)
    }

    @ViewBuilder
    func makeDetailView(forecastDatetime: Date) -> some View {
        let viewModel = DetailViewModel(forecastDatetime: forecastDatetime)

        DetailView(viewModel: viewModel)
    }

    func routeToDetail(forecastDatetime: Date) {
        route(to: \.detailView, forecastDatetime)
    }
}
