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
        // ???: Shouldn't there just be one singleton of access to the store of the settings that's not necessarily injected into the view here?
        HomeLandingView(with: SettingsStore())
        if launchScreenState.state != .finish {
          LaunchScreen()
        }
      }.environmentObject(launchScreenState)
    }
  }
}
