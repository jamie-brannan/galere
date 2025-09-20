//
//  HomeLandingView.swift
//  galere
//
//  Created by Jamie Brannan on 18/11/2022.
//

import DesignSystem
import SwiftUI

/// The view that appears after ``LaunchScreen`` and is the central hub for the Galère gallery experience.
struct HomeLandingView: View {
  @ObservedObject var settingsStore: SettingsStore
  @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

  init(settingsStore: SettingsStore) {
    self.settingsStore = settingsStore
  }

  var body: some View {
    NavigationView {
      VStack {
        heroImageView
        welcomeHeaderText
        TestDesignSystemConnection()
      }
      .toolbar {
        menuButtonview
      }
      .padding()
      .task {
        self.launchScreenState.dismiss()
      }
    }
  }

  var heroImageView: some View {
    Image(systemName: "globe")
      .imageScale(.large)
      .foregroundColor(.accentColor)
  }

  var welcomeHeaderText: some View {
    Text("Hello, Galère!")
      .font(.settingsBased(settingsStore, style: .title))
  }

  var menuButtonview: some View {
    NavigationLink(destination: MainMenuView(settingsStore: settingsStore)) {
      Text("Menu")
    }
  }
}

@available(iOS 17.0, *)
#Preview("Landing view", traits: .sizeThatFitsLayout) {
  HomeLandingView(settingsStore: SettingsStore())
    .environmentObject(LaunchScreenStateManager())
}
