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
  // MARK: - Properties

  // MARK: Constants
  let fontStyle: Font.TextStyle = .title
  var menuDestination: MainMenuView {
    MainMenuView(settingsStore: self.settingsStore)
  }

  // MARK: Data
  // LOCAL
  @ObservedObject var settingsStore: SettingsStore
  @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

  // MARK: - Lifecycle
  init(with settingsStore: SettingsStore) {
    self.settingsStore = settingsStore
  }

  // MARK: - Layout
  var body: some View {
    NavigationView {
      pageView
      .toolbar {
        menuButtonview
      }
      .padding()
      .task {
        /// ???: Does this actually do anything?
        self.launchScreenState.dismiss()
      }
    }
  }

  var pageView: some View {
    VStack {
      heroImageView
      welcomeHeaderText
      TestDesignSystemConnection()
    }
  }

  // MARK: - Child views
  var heroImageView: some View {
    Image(systemName: "globe")
      .imageScale(.large)
      .foregroundColor(.accentColor)
  }

  var welcomeHeaderText: some View {
    Text("Hello, Galère!")
      .font(.settingsBased(settingsStore, style: fontStyle))
  }

  var menuButtonview: some View {
    NavigationLink(destination: menuDestination) {
      Text("Menu")
    }
  }
}

@available(iOS 17.0, *)
#Preview("Landing view", traits: .sizeThatFitsLayout) {
  HomeLandingView(with: SettingsStore())
    .environmentObject(LaunchScreenStateManager())
}
