//
//  GalereApp.swift
//  galere
//
//  Created by Jamie Brannan on 17/01/2024.
//

import SwiftUI

/// The beating heart of the app!
@main
struct GalereApp: App {
  @StateObject var launchScreenState = LaunchScreenStateManager()

  var body: some Scene {
    WindowGroup {
      ZStack {
        HomeLandingView(settingsStore: SettingsStore())
        if launchScreenState.state != .finish {
          LaunchScreen()
        }
      }.environmentObject(launchScreenState)
    }
  }
}
