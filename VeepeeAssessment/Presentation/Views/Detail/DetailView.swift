//
//  DetailView.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Factory
import Foundation
import SwiftUI

struct DetailView: View {
    @ObservedObject
    var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
        }
    }
}
