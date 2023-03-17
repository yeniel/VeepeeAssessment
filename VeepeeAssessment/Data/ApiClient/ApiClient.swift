//
//  ApiClient.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

protocol ApiClient {
    func get<T: Decodable>(url: String) async throws -> T
    // Commented code because in this small project is not needed yet
//    func post<T>(path: String, data: T) -> AnyPublisher<T, CabifyError>
//    func put<T>(path: String, data: T) -> AnyPublisher<T, CabifyError>
//    func patch<T>(path: String, data: T) -> AnyPublisher<T, CabifyError>
//    func delete<T>(path: String) -> AnyPublisher<T, CabifyError>
}
