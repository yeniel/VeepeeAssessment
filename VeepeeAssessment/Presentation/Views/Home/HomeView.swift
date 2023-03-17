//
//  HomeView.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject
    var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.status {
        case .loading:
            VStack {
                ProgressView()
            }
        case .loaded:
            VStack {
            }

        }
    }
}
