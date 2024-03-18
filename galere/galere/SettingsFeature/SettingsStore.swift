//
//  SettingsStore.swift
//  galere
//
//  Created by Jamie Brannan on 18/03/2024.
//

import Combine
import Foundation
import SwiftUI

/// The object from which changes to the global app settings are to be published and subscribed to
class SettingsStore: ObservableObject {
  @Published var settings: Settings

  init() {
    guard let taskJsonUrl = Bundle.main.url(forResource: "default", withExtension: "json") else {
      self.settings = Settings(font: .pirata, size: 14)
      return
    }

    let decoder = JSONDecoder()

    do {
      let taskData = try Data(contentsOf: taskJsonUrl)
      let task = try decoder.decode(Settings.self, from: taskData)
      self.settings = task
      return
    } catch let error {
      #if DEBUG
      print("\(error)") // TODO: chose logging/reporting tool
      #endif
      self.settings = Settings(font: .pirata, size: 108) // TODO: Something else hardcoded
      return
    }
  }

}
