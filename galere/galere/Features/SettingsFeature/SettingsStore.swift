//
//  SettingsStore.swift
//  galere
//
//  Created by Jamie Brannan on 18/03/2024.
//

import Combine
import Foundation
import SwiftUI

// TODO: Add unit test for this
/// The object from which changes to the global app settings are to be published and subscribed to
public class SettingsStore: ObservableObject {
  let saveUrl = URL(fileURLWithPath: "MySettings", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")

  @Published var settings: Settings {
    didSet {
      saveSettingsToDisk()
    }
  }

  init() {
    /// No matter where it's from, we'll be decoding JSON data format
    let decoder = JSONDecoder()

    /// See if we already have a saved setting
    guard FileManager.default.fileExists(atPath: saveUrl.path) else {

      /// IF NOT, get the default json setting located in the app's bundle
      guard let taskJsonUrl = Bundle.main.url(forResource: "default", withExtension: "json") else {
        self.settings = Settings(font: .chewy, size: 14)
        return
      }

      do {
        let taskData = try Data(contentsOf: taskJsonUrl)
        let task = try decoder.decode(Settings.self, from: taskData)
        self.settings = task
        return
      } catch let error {
        print(error)
        self.settings = Settings(font: .chewy, size: 108)
        return
      }
    }

    /// IF SO, decode our saved json from the users directory of `FileManager`
    do {
      let taskData = try Data(contentsOf: saveUrl)
      let task = try decoder.decode(Settings.self, from: taskData)
      self.settings = task
    } catch let error {
      print(error)
      self.settings = Settings(font: .chewy, size: 108)
    }
  }

  /// When the user has expressed their own view of settings (lumped together for now) write into a json file for now
  /// In a fully scaled project, would be stored in a back-end user account of some kind that would write information to a data base
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
