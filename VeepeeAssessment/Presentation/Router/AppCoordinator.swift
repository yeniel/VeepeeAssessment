//
//  AppCoordinator.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation
import Stinsen
import Factory
import SwiftUI

final class AppCoordinator: NavigationCoordinatable {
    @Injected(\.mainCoordinator)
    private var mainCoordinator: MainCoordinatorImpl

    let stack = NavigationStack(initial: \AppCoordinator.start)

    lazy var routerStorable: AppCoordinator = self

    @Root
    var start = makeStart

    func makeStart() -> NavigationViewCoordinator<MainCoordinatorImpl> {
        NavigationViewCoordinator(mainCoordinator)
    }

}
