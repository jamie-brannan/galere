//
//  FontExtensions.swift
//  galere
//
//  Created by Jamie Brannan on 06/03/2024.
//

import SwiftUI

// MARK: - Custom Fonts

public extension Font {

  /// Font file names that have been added to the `xcproj` from Google Fonts
  enum CustomFonts: String, CaseIterable, Codable {
    /// Source: https://fonts.google.com/specimen/Chewy?classification=Display
    case chewy = "Chewy-Regular"
    /// Source: https://fonts.google.com/specimen/Jacquarda+Bastarda+9?query=jacquarda&classification=Display
    case jacquarda = "JacquardaBastarda9-Regular"
    /// Source: https://fonts.google.com/specimen/Micro+5?query=micro+5&classification=Display
    case micro = "Micro5-Regular"
    /// Source: https://fonts.google.com/specimen/Pirata+One?classification=Display
    case pirata = "PirataOne-Regular"
  }

  /// Using a font added regardless of the ``SettingsStore`` state.
  ///   - Parameter customFont:Only chose form added font files
  ///   - Parameter size: Size to render the font in
  ///   - Parameter relativeTo: Dynamic Type scaling porportion based on Apple's ``Font.TextStyle``
  static func addedFonts(_ customFont: CustomFonts, size: CGFloat?, relativeTo style: Font.TextStyle) -> Font {
    return Font.custom(customFont.rawValue, size: size ?? 16, relativeTo: style)
  }

  /// When using a font programed with ``Settings`` currently in the ``SettingsStore``, only need to pass the store and it's style
  ///   - Parameter store: The ``SettingsStore`` observed at the time
  ///   - Parameter relativeTo: Dynamic Type scaling porportion based on Apple's ``Font.TextStyle``
  ///
  /// ## In the future
  ///  The `Font.TextStyle` per font setting may be added in ``Settings`` and this function cound be handled otherwise
  static func settingsBased(_ store: SettingsStore, style: Font.TextStyle) -> Font {
    return Font.custom(store.settings.font.rawValue, size: store.settings.size, relativeTo: style)
  }
}

#Preview("Custom Font Collection Preview") {
  VStack(alignment: .leading) {
    Text("`Font.CustomFont` collection name and their rendering:")
      .padding()
    List {
      ForEach(Font.CustomFonts.allCases, id: \.self) { sample in
        Text(sample.rawValue)
          .font(.addedFonts(sample, size: 16, relativeTo: .body))
          .padding()
      }
    }
  }
}
