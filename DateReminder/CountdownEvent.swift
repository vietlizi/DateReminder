//
//  CountdownEvent.swift
//  DateReminder
//
//  Created by Hodaka on 13/3/25.
//


import Foundation

struct CountdownEvent: Identifiable {
    let id = UUID()
    var name: String
    var date: Date

    var daysLeft: Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: now, to: date)
        return components.day ?? 0
    }
}
