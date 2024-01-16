//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Brandon Johns on 1/15/24.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification)) { _ in
                    dataController.save()
                }
        }
    }
}
