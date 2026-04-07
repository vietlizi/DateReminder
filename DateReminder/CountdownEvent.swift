//
//  CountdownEvent.swift
//  DateReminder
//

import Foundation

struct CountdownEvent: Identifiable, Codable {
    var id = UUID()
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

    var detailedTimeLeft: (days: Int, hours: Int, minutes: Int) {
        let cal = Calendar.current
        let components = cal.dateComponents([.day, .hour, .minute], from: Date(), to: date)
        return (
            max(components.day ?? 0, 0),
            max(components.hour ?? 0, 0),
            max(components.minute ?? 0, 0)
        )
    }

    var percentLeft: Double {
        let cal = Calendar.current
        let year = cal.component(.year, from: date)
        let startOfYear = cal.date(from: DateComponents(year: year, month: 1, day: 1)) ?? startDate
        let total = date.timeIntervalSince(startOfYear)
        let remaining = date.timeIntervalSince(Date())
        
        guard total > 0 else { return 0 }
        return max(min(remaining / total * 100.0, 100.0), 0.0)
    }
}
