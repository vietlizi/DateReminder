//
//  CountdownManager.swift
//  DateReminder
//
//  Created by Hodaka on 13/3/25.
//


import SwiftUI

class CountdownManager: ObservableObject {
    @Published var events: [CountdownEvent] = []
    @Published var selectedEvent: CountdownEvent?
    @Published var statusBarText: String = "Loading..."

    init() {
        loadDefaultEvents()
        updateStatusBarText()
    }

    func loadDefaultEvents() {
        let calendar = Calendar.current

        let defaultDates: [(String, DateComponents)] = [
            ("TSA", DateComponents(year: 2025, month: 4, day: 26)),
            ("THPT QG", DateComponents(year: 2025, month: 6, day: 27)),
            ("New Year", DateComponents(year: 2026, month: 1, day: 1)),
            ("Lunar New Year", DateComponents(year: 2026, month: 2, day: 17))
        ]

        self.events = defaultDates.compactMap { name, components in
            if let eventDate = calendar.date(from: components) {
                return CountdownEvent(name: name, date: eventDate)
            }
            return nil
        }

        if let firstEvent = events.first {
            selectedEvent = firstEvent
        }
        updateStatusBarText()
    }

    func updateStatusBarText() {
        if let event = selectedEvent {
            statusBarText = "\(event.name): \(event.daysLeft) days left"
        } else {
            statusBarText = "No upcoming events"
        }
    }

    func selectEvent(_ event: CountdownEvent) {
        DispatchQueue.main.async {
            self.selectedEvent = event
            self.updateStatusBarText()
        }
    }
}
