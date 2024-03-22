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
    /// See if we already have a saved setting
    guard JsonManager.isAlreadyALocalFile(named: saveName) else {
      /// IF NOT, get the default json setting located in the app's bundle
      guard let failThrough = JsonManager.loadBackupJsonFor(model: Settings.self, from: "default") else {
        self.settings = Settings(font: .chewy, size: 14) // TODO: Fix failsafe duplicate
        return
      }
      self.settings = failThrough
      return
    }
    /// IF SO, decode our saved json from the users directory of `FileManager` otherwise use raw failsafe
    self.settings = JsonManager.loadUserDefaultJson(named: saveName, forType: Settings.self) ?? Settings(font: .chewy, size: 14) // TODO: Fix failsafe duplicate
  }

  /// When the user has expressed their own view of settings (lumped together for now) write into a json file for now
  /// In a fully scaled project, would be stored in a back-end user account of some kind that would write information to a data base
  private func saveSettingsToDisk() {
    JsonManager.writeUserDefaultJson(inFileNamed: saveName, withValues: settings)
  }
}
