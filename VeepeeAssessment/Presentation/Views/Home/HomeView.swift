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
            Text(error)
                .foregroundColor(Color.red)
        case .loading:
            ProgressView()
            .task {
                await viewModel.getForecastList()
            }
        case .loaded:
            List {
                ForEach(viewModel.forecastList) { forecast in
                    HStack {
                        Text(forecast.datetime)
                            .font(.body)
                        Spacer()
                        CachedAsyncImage(url: URL(string: forecast.icon)) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                        HStack {
                            Text(forecast.minTemperature)
                                .font(.body)
                                .foregroundColor(Color.gray)
                            Text("-")
                            Text(forecast.maxTemperature)
                                .font(.body)
                                .bold()
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.routeToDetail(forecastDatetime: forecast.id)
                    }
                }
            }
        }
    }
}
