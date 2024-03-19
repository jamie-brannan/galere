//
//  galereApp.swift
//  galere
//
//  Created by Jamie Brannan on 17/01/2024.
//

import SwiftUI

@main
struct GalereApp: App {
  var body: some Scene {
    WindowGroup {
      ZStack {
        ContentView(settingsStore: SettingsStore())
        
      }
    }
  }
}
