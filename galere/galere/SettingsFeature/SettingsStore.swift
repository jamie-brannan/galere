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
public class SettingsStore: ObservableObject {
  let saveUrl = URL(fileURLWithPath: "MySettings", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")

  @Published var settings: Settings {
    didSet {
      saveSettingsToDisk()
    }
  }

  init() {
    // TODO: check for a `MySettings.json` first before defaulting
    let decoder = JSONDecoder()

    /// See if we already have a saved setting
    guard FileManager.default.fileExists(atPath: saveUrl.path) else {

      /// Or else get the default json setting
      guard let taskJsonUrl = Bundle.main.url(forResource: "default", withExtension: "json") else {
        self.settings = Settings(font: .pirata, size: 14)
        return
      }

      do {
        let taskData = try Data(contentsOf: taskJsonUrl)
        let task = try decoder.decode(Settings.self, from: taskData)
        self.settings = task
        return
      } catch let error {
        //      #if DEBUG
        print("\(error)") // TODO: chose logging/reporting tool
        //      #endif
        self.settings = Settings(font: .pirata, size: 108) // TODO: Something else hardcoded
        return
      }
    }

    /// Decode our saved json
    do {
      let taskData = try Data(contentsOf: saveUrl)
      let task = try decoder.decode(Settings.self, from: taskData)
      self.settings = task
    } catch let error {
      print(error)
      self.settings = Settings(font: .pirata, size: 108)
    }
  }

  /// Simply read to see if the user has already saved settings before on this device
  func isAlreadySaved() -> Bool {
    let check = FileManager.default.fileExists(atPath: "MySettings.json")
    return check
  }

  func loadJson(from url: URL) {
    
  }
  /// When the user has expressed their own view of settings (lumped together for now) write into a json file for now
  /// In a fully scaled project, would be stored in a back-end user account of some kind that would write information to a data base
  // TODO: Mark a way in DocC future path ideas with larger scope and infrastructure
  // TODO: Seperate encode and writing the encoded json?
  private func saveSettingsToDisk() {
    let encoder = JSONEncoder()

    do {
      let taskData = try encoder.encode(settings)
      try taskData.write(to: saveUrl)
    } catch let error {
      print(error)
    }
  }
}
