//  DateReminderApp.swift
//  DateReminder

import SwiftUI
import UserNotifications

@main
struct DateReminderApp: App {
    @StateObject private var countdownManager = CountdownManager()
    @StateObject private var pomodoroManager  = PomodoroManager()

    var body: some Scene {
        MenuBarExtra {
            RootView()
                .environmentObject(countdownManager)
                .environmentObject(pomodoroManager)
                .preferredColorScheme(.dark)
                .environment(\.locale, Locale(identifier: countdownManager.currentLanguage))
        } label: {
            Text(pomodoroManager.isRunning
                 ? pomodoroManager.menuBarText
                 : countdownManager.statusBarText)
                .monospacedDigit()
                .animation(.none, value: pomodoroManager.menuBarText)
        }
        .menuBarExtraStyle(.window)
    }
}
