//
//  ContentView.swift
//  DateReminder
//
//  Created by Hodaka on 13/3/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var countdownManager: CountdownManager

    var body: some View {
        VStack {
            Text("Select Event to Display").bold()

            List(countdownManager.events, id: \.id) { event in
                Button(action: {
                    countdownManager.selectEvent(event)
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
