//
//  ApiClient.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

/// Protocol to define http operations
protocol ApiClient {
    func get<T: Decodable>(url: String) async throws -> T
}
