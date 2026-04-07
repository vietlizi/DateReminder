//
//  CountdownEvent.swift
//  DateReminder
//

import Foundation

struct CountdownEvent: Identifiable {
    let id = UUID()
    var name: String
    var date: Date
    var startDate: Date

    var daysLeft: Int {
        let cal = Calendar.current
        let components = cal.dateComponents([.day], from: Date(), to: date)
        return max(components.day ?? 0, 0)
    }

    var hoursLeft: Int {
        return max(Int(date.timeIntervalSince(Date()) / 3600), 0)
    }

    var percentLeft: Double {
        let total     = date.timeIntervalSince(startDate)
        let remaining = date.timeIntervalSince(Date())
        guard total > 0 else { return 0 }
        return max(min(remaining / total * 100.0, 100.0), 0.0)
    }
}
