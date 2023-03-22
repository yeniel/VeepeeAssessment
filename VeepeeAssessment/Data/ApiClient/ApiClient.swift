//
//  ApiClient.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

protocol ApiClient {
    func get<T: Decodable>(url: String) async throws -> T
}
