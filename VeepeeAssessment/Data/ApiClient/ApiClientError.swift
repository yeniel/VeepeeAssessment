//
//  ApiClientError.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

enum ApiClientError: Error{
    case badUrl, requestError, decodingError, statusNotOK
}
