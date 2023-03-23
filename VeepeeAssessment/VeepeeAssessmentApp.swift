//
//  VeepeeAssessmentApp.swift
//  VeepeeAssessment
//
//  Created by Yeniel Landestoy on 17/3/23.
//

import SwiftUI
import Stinsen
import Factory
import CoreData

/// To increase the speed I change a little the entry point of the app, in `VeepeeAssessmentApp.swift`.
/// I cut the app to a simple view in case we are running the tests.
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
    @Injected(\.container)
    var container: NSPersistentContainer

    @Injected(\.networkMonitor)
    var networkMonitor: NetworkMonitor

    init() {
        initCoreData()
        networkMonitor.start()
    }

    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            AppCoordinator().view()
        }
    }

    private func initCoreData() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unable to load persistent stores: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
