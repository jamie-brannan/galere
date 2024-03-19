//
//  ContentView.swift
//  galere
//
//  Created by Jamie Brannan on 18/11/2022.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var settingsStore: SettingsStore

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
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(settingsStore: SettingsStore())
  }
}
