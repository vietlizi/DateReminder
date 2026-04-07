//
//  MenuView.swift
//  DateReminder
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var countdownManager: CountdownManager

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Current countdown detail ──────────────────────────────
            if let event = countdownManager.selectedEvent {
                VStack(alignment: .leading, spacing: 2) {
                    Text(event.name)
                        .font(.headline)
                        .padding(.horizontal, 12)
                        .padding(.top, 10)

                    Group {
                        detailRow(icon: "percent",
                                  text: "\(String(format: "%.1f", event.percentLeft))% until \(event.name)")
                        detailRow(icon: "calendar",
                                  text: "\(event.daysLeft) days until \(event.name)")
                        detailRow(icon: "clock",
                                  text: "\(event.hoursLeft) hours until \(event.name)")
                    }
                    .padding(.bottom, 2)
                }
            }

            Divider().padding(.vertical, 4)

            // ── Display mode ─────────────────────────────────────────
            sectionHeader("Menu Bar Shows")

            ForEach(DisplayMode.allCases, id: \.self) { mode in
                Button(action: { countdownManager.selectDisplayMode(mode) }) {
                    HStack {
                        Text(mode.rawValue)
                        Spacer()
                        if countdownManager.displayMode == mode {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }

            Divider().padding(.vertical, 4)

            // ── Event selection ───────────────────────────────────────
            sectionHeader("Event")

            ForEach(countdownManager.events, id: \.id) { event in
                Button(action: { countdownManager.selectEvent(event) }) {
                    HStack {
                        Text(event.name)
                        Spacer()
                        if countdownManager.selectedEvent?.id == event.id {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }

            Divider().padding(.vertical, 4)

            Button("Quit") { NSApplication.shared.terminate(nil) }
                .padding(.bottom, 4)
        }
        .frame(minWidth: 220)
    }

    @ViewBuilder
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal, 12)
            .padding(.bottom, 2)
    }

    @ViewBuilder
    private func detailRow(icon: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .frame(width: 14)
                .foregroundColor(.secondary)
            Text(text)
                .monospacedDigit()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
    }
}
