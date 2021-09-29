//
//  BusWatchApp.swift
//  BusWatch WatchKit Extension
//
//  Created by Jason Chow on 29/9/2021.
//

import SwiftUI

@main
struct BusWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
