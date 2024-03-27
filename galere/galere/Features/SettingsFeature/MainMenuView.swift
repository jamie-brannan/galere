//
//  SettingsMenuView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

struct MainMenuView: View {
  @ObservedObject var settingsStore: SettingsStore

  var body: some View {
    VStack(alignment: .leading) {
      List {
        Section(header: Text("Settings")) {
          NavigationLink(destination: FontSettingsView(settingsStore: settingsStore)) {
            Label("Font Settings", systemImage: "textformat.size")
          }
        }
        Section(header: Text("Other")) {
          Text("Other")
        }
      }
    }
    .navigationTitle("Main Menu")
    .navigationBarTitleDisplayMode(.large)
  }
}

#Preview {
    MainMenuView(settingsStore: SettingsStore())
}
