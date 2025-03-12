//
//  MenuView.swift
//  DateReminder
//
//  Created by Hodaka on 13/3/25.
//


import SwiftUI

struct MenuView: View {
    @EnvironmentObject var countdownManager: CountdownManager  // 🔥 Fix EnvironmentObject reference

    var body: some View {
        VStack {
            Text("Select Event to Display").bold()

            ForEach(countdownManager.events, id: \.id) { event in
                Button(action: {
                    countdownManager.selectEvent(event)  // 🔥 Fix method call
                }) {
                    Text(event.name)
                }
            }

            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
    }
}
