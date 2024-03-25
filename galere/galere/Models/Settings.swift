//
//  Settings.swift
//  galere
//
//  Created by Jamie Brannan on 18/03/2024.
//

import SwiftUI

/// Format for stored in ``SettingsStore`` and managed by the user in ``FontSettingsView``
struct Settings: Codable {
  var font: Font.CustomFonts
  var size: CGFloat
}
