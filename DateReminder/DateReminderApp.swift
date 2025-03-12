//
//  DateReminderApp.swift
//  DateReminder
//
//  Created by Hodaka on 13/3/25.
//

import SwiftUI

@main
struct DateReminderApp: App {
    @StateObject var countdownManager = CountdownManager()

    var body: some Scene {
        MenuBarExtra {
            MenuView()
                .environmentObject(countdownManager)
        } label: {
            Text(countdownManager.statusBarText)
        }
        .menuBarExtraStyle(.menu)
    }
}
