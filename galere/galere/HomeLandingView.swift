//
//  HomeLandingView.swift
//  galere
//
//  Created by Jamie Brannan on 18/11/2022.
//

import SwiftUI

struct HomeLandingView: View {
  @ObservedObject var settingsStore: SettingsStore
  @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

  init(settingsStore: SettingsStore) {
    self.settingsStore = settingsStore
  }

  var body: some View {
    NavigationView {
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundColor(.accentColor)
        Text("Hello, Galère!")
          .font(.settingsBased(settingsStore, style: .title))
      }
      .toolbar {
        NavigationLink(destination: FontSettingsView(settingsStore: settingsStore)) {
          Text("Temporary Settings")
        }
      }
      .padding()
      .task {
        self.launchScreenState.dismiss()
      }
    }
  }
}

struct HomeLandingView_Previews: PreviewProvider {
  static var previews: some View {
    HomeLandingView(settingsStore: SettingsStore())
  }
}
