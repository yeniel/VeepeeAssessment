//
//  HomeView.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    @ObservedObject
    var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.status {
        case .failed(let error):
            Text(error.localizedDescription)
        case .loading:
            ProgressView()
            .task {
                await viewModel.getForecast()
            }
        case .loaded:
            List {
                ForEach(viewModel.forecast) { dayForecast in
                    HStack {
                        Text(dayForecast.datetime)
                            .font(.body)
                        Spacer()
                        AsyncImage(url: URL(string: dayForecast.icon)) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                        HStack {
                            Text(dayForecast.minTemperature)
                                .font(.callout)
                                .foregroundColor(Color.gray)
                            Text("-")
                            Text(dayForecast.maxTemperature)
                                .font(.body)
                                .bold()
                        }
                    }
                }
            }
        }
    }
}
