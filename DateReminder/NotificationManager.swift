//
//  NotificationManager.swift
//  DateReminder
//
//  Created by Hodaka on 7/4/26.
//


//  NotificationManager.swift
//  DateReminder

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    // ── Permission ───────────────────────────────────────────────────
    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error { print("Notification auth error: \(error)") }
                print("Notification permission granted: \(granted)")
            }
    }

    // ── 9 AM daily reminder ──────────────────────────────────────────
    /// Call this once on launch (and again if the selected event changes).
    /// It removes any existing daily reminder before scheduling a fresh one
    /// so you never end up with duplicates.
    func scheduleDailyReminder(manager: CountdownManager) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["daily-reminder"])

        guard let event = manager.selectedEvent else { return }

        let content           = UNMutableNotificationContent()
        content.title         = NSLocalizedString("notif_daily_title",
                                    value: "Good morning! ☀️",
                                    comment: "Daily reminder title")
        content.body          = buildBody(event: event, quote: manager.todaysQuote)
        content.sound         = .default

        // Fire every day at 09:00 local time
        var triggerComponents       = DateComponents()
        triggerComponents.hour      = 9
        triggerComponents.minute    = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents,
                                                     repeats: true)

        let request = UNNotificationRequest(identifier: "daily-reminder",
                                            content: content,
                                            trigger: trigger)
        center.add(request) { error in
            if let error { print("Failed to schedule daily reminder: \(error)") }
        }
    }
        func triggerDebugNotification(manager: CountdownManager) {
            guard let event = manager.selectedEvent else { return }

            let content           = UNMutableNotificationContent()
            content.title         = "DEBUG: Notification Test"
            content.body          = buildBody(event: event, quote: manager.todaysQuote)
            content.sound         = .default

            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content,
                                                trigger: nil)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error { print("Failed to fire debug notification: \(error)") }
            }
        }
    // ── Helpers ──────────────────────────────────────────────────────
    private func buildBody(event: CountdownEvent, quote: DailyQuote) -> String {
        let dayLine = String(
            format: NSLocalizedString("notif_daily_body",
                        value: "%d days until %@.",
                        comment: "e.g. '39 days until TSA Exam.'"),
            event.daysLeft, event.name)
        return "\(dayLine)\n\"\(quote.text)\" — \(quote.author)"
    }
}
