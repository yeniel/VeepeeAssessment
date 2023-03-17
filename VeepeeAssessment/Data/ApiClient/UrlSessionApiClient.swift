//
//  UrlSessionApiClient.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct UrlSessionApiClient: ApiClient {
    static let host = "https://api.openweathermap.org"
    let decoder: JSONDecoder = .init()

    func get<T: Decodable>(path: String) async throws -> T {
        guard let url = URL(string: "\(UrlSessionApiClient.host)/\(path)") else {
            throw ApiClientError.badUrl
        }

        let urlRequest = configureUrlRequest(url: url)

        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw ApiClientError.requestError
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiClientError.statusNotOK
        }

        guard let dto = try? JSONDecoder().decode(T.self, from: data) else {
            throw ApiClientError.decodingError
        }

        return dto
    }

    private func configureUrlRequest(url: URL, method: HttpMethod = .GET) -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.addValue("application/json; charset=iso-8859-1", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
}
