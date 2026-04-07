//
//  RootView.swift
//  DateReminder
//
//  Created by Hodaka on 7/4/26.
//


//  RootView.swift
//  DateReminder

import SwiftUI

/// Top-level container rendered inside the MenuBarExtra window.
/// Hosts a tab bar to switch between the countdown and Pomodoro views.
struct RootView: View {
    @EnvironmentObject var countdownManager: CountdownManager
    @EnvironmentObject var pomodoroManager:  PomodoroManager

    @State private var selectedTab: Tab = .countdown

    enum Tab { case countdown, pomodoro }

    // Gradient shared by both tabs as the window background
    private let background = LinearGradient(
        colors: [Color(red: 0.08, green: 0.08, blue: 0.14),
                 Color(red: 0.12, green: 0.08, blue: 0.20)],
        startPoint: .topLeading,
        endPoint:   .bottomTrailing
    )

    var body: some View {
        ZStack(alignment: .bottom) {
            background.ignoresSafeArea()

            VStack(spacing: 0) {
                // ── Content ──────────────────────────────────────────
                Group {
                    switch selectedTab {
                    case .countdown: BeautifulCountdownView()
                    case .pomodoro:  PomodoroView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                // ── Tab bar ──────────────────────────────────────────
                Divider().background(Color.white.opacity(0.10))

                HStack(spacing: 0) {
                    tabButton(
                        icon:  "calendar.badge.clock",
                        label: "Countdown",
                        tab:   .countdown
                    )
                    tabButton(
                        icon:  "timer",
                        label: "Pomodoro",
                        tab:   .pomodoro,
                        badge: pomodoroManager.isRunning
                    )
                }
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.04))
            }
        }
        .frame(width: 320, height: 420)
    }

    // ── Tab button ───────────────────────────────────────────────────
    @ViewBuilder
    private func tabButton(icon: String,
                           label: String,
                           tab: Tab,
                           badge: Bool = false) -> some View {
        let isSelected = selectedTab == tab
        Button {
            withAnimation(.easeInOut(duration: 0.2)) { selectedTab = tab }
        } label: {
            VStack(spacing: 3) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                        .foregroundColor(isSelected ? .white : .white.opacity(0.4))

                    // Live indicator dot for Pomodoro
                    if badge {
                        Circle()
                            .fill(Color(red: 1, green: 0.35, blue: 0.35))
                            .frame(width: 6, height: 6)
                            .offset(x: 4, y: -2)
                    }
                }

                Text(label)
                    .font(.system(size: 9, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .background(
                isSelected
                    ? RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.10))
                    : nil
            )
            .padding(.horizontal, 12)
        }
        .buttonStyle(.plain)
    }
}