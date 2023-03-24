//
//  TestTimeZoneProvider.swift
//  VeepeeAssessmentTests
//
//  Created by Yeniel Landestoy on 24/3/23.
//

import Foundation

struct TestTimeZoneProvider: TimeZoneProvider {
    let timeZone = TimeZone(identifier: "Europe/Paris")!
}
