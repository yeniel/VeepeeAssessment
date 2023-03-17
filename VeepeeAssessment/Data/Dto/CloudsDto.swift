//
//  CloudsDto.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import Foundation

struct CloudsDto: Codable {
    let cloudiness: Int

    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
