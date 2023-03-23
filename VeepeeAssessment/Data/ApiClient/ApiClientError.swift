//
//  ApiClientError.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

/// Define API errors to map `URLSession` erros
enum ApiClientError: Error {
    case badUrl, requestError, decodingError, statusNotOK
}
