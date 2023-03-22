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
