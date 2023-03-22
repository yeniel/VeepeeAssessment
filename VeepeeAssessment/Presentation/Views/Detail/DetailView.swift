//
//  DetailView.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    @ObservedObject
    var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
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
            ScrollView {
                VStack {
                    Text(viewModel.forecast.datetime)
                        .font(.title)
                    HStack {
                        CachedAsyncImage(url: URL(string: viewModel.forecast.weatherIcon)) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        VStack {
                            Text(viewModel.forecast.temperature)
                                .font(.largeTitle)
                                .bold()
                            Text("Feels like \(viewModel.forecast.feelsLike)")
                        }
                    }
                    Text(viewModel.forecast.weatherDescription)
                        .font(.body)
                    Divider()
                    Group {
                        RowDetail(label: "Min Temperature", value: viewModel.forecast.temperatureMin)
                        RowDetail(label: "Max Temperature", value: viewModel.forecast.temperatureMax)
                        RowDetail(
                            label: "Probability of Precipitation",
                            value: viewModel.forecast.precipitationProbability
                        )
                        RowDetail(label: "Wind", value: viewModel.forecast.wind)
                        RowDetail(label: "Humidity", value: viewModel.forecast.humidity)
                        RowDetail(label: "Visibility", value: viewModel.forecast.visibility)
                        RowDetail(label: "Pressure", value: viewModel.forecast.pressure)
                    }
                    Divider()
                }
            }
            .padding()
        }
    }
}

struct RowDetail: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.footnote)
            Spacer()
            Text(value)
                .font(.footnote)
                .bold()
        }
    }
}
