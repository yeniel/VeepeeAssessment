//
//  VeepeeAssessmentApp.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import SwiftUI
import Stinsen

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            VeepeeAssessmentApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct VeepeeAssessmentApp: App {
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            AppCoordinator().view()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
