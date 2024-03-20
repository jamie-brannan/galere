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
  let saveName = "MySettings"

  @Published var settings: Settings {
    didSet {
      saveSettingsToDisk()
    }
  }

  init() {
    /// No matter where it's from, we'll be decoding JSON data format
    let decoder = JSONDecoder()

    /// See if we already have a saved setting
    guard JsonCodables.isAlreadyALocalFile(named: saveName) else {

      /// IF NOT, get the default json setting located in the app's bundle
      guard let failThrough = JsonCodables.loadBackupJsonFor(model: Settings.self, from: "default") else {
        self.settings = Settings(font: .chewy, size: 14) // TODO: Fix failsafe duplicate
        return
      }
      self.settings = failThrough
      return
    }

    /// IF SO, decode our saved json from the users directory of `FileManager`
    self.settings = JsonCodables.loadUserDefaultJson(named: saveName, forType: Settings.self) ?? Settings(font: .chewy, size: 14) // TODO: Fix failsafe duplicate
  }

  /// When the user has expressed their own view of settings (lumped together for now) write into a json file for now
  /// In a fully scaled project, would be stored in a back-end user account of some kind that would write information to a data base
  private func saveSettingsToDisk() {
    let encoder = JSONEncoder()

    do {
      let taskData = try encoder.encode(settings)
      try taskData.write(to: URL(fileURLWithPath: "MySettings", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json"))
    } catch let error {
      print(error)
    }
  }
}
