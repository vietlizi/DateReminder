//
//  CountdownManager.swift
//  DateReminder
//

import SwiftUI

enum DisplayMode: String, CaseIterable {
    case percent = "% until"
    case days    = "Days until"
    case hours   = "Hours until"
}

class CountdownManager: ObservableObject {
    @Published var events: [CountdownEvent] = []
    @Published var selectedEvent: CountdownEvent?
    @Published var displayMode: DisplayMode = .percent
    @Published var statusBarText: String = "Loading..."

    private var refreshTimer: Timer?

    init() {
        loadDefaultEvents()
        updateStatusBarText()
        startRefreshTimer()
    }

    deinit { refreshTimer?.invalidate() }

    func loadDefaultEvents() {
        let calendar = Calendar.current
        let now = Date()

        let tsaDate  = calendar.date(from: DateComponents(year: 2026, month: 5, day: 16))!
        let tsaStart = calendar.date(from: DateComponents(year: 2026, month: 1, day: 1))!

        let todayStart   = calendar.startOfDay(for: now)
        let tomorrowDate = calendar.date(byAdding: .day, value: 1, to: todayStart)!

        let newEvents: [CountdownEvent] = [
            CountdownEvent(name: "TSA Exam", date: tsaDate,      startDate: tsaStart),
            CountdownEvent(name: "Tomorrow", date: tomorrowDate, startDate: todayStart),
        ]

        let previousName = selectedEvent?.name
        self.events = newEvents
        selectedEvent = newEvents.first(where: { $0.name == previousName }) ?? newEvents.first
        updateStatusBarText()
    }

    func updateStatusBarText() {
        guard let event = selectedEvent else {
            statusBarText = "No upcoming events"
            return
        }
        switch displayMode {
        case .percent:
            statusBarText = "\(String(format: "%.1f", event.percentLeft))% until \(event.name)"
        case .days:
            statusBarText = "\(event.daysLeft) days until \(event.name)"
        case .hours:
            statusBarText = "\(event.hoursLeft) hours until \(event.name)"
        }
    }

    func selectEvent(_ event: CountdownEvent) {
        DispatchQueue.main.async {
            self.selectedEvent = event
            self.updateStatusBarText()
        }
    }

    func selectDisplayMode(_ mode: DisplayMode) {
        DispatchQueue.main.async {
            self.displayMode = mode
            self.updateStatusBarText()
        }
    }

    private func startRefreshTimer() {
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.loadDefaultEvents()
                self?.updateStatusBarText()
            }
        }
    }
}
