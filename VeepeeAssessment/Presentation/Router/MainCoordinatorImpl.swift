//
//  MainCoordinatorImpl.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Stinsen
import SwiftUI

final class MainCoordinatorImpl: MainCoordinator, NavigationCoordinatable {
    let stack = NavigationStack(initial: \MainCoordinatorImpl.start)

    lazy var routerStorable: MainCoordinator = self

    @Root
    var start = makeStart

    @Route(.push)
    var detailView = makeDetailView

    @ViewBuilder
    func makeStart() -> some View {
        let viewModel = HomeViewModel()

        HomeView(viewModel: viewModel, mainCoordinator: self)
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
