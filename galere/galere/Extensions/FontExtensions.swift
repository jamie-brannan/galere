//
//  FontExtensions.swift
//  galere
//
//  Created by Jamie Brannan on 06/03/2024.
//

import SwiftUI

// MARK: - Custom Fonts

public extension Font {

  enum CustomFonts: String, CaseIterable, Codable {
    case chewy = "Chewy-Regular"
    case jacquarda = "JacquardaBastarda9-Regular"
    case micro = "Micro5-Regular"
    case pirata = "PirataOne-Regular"
  }

  static func addedFonts(_ customFont: CustomFonts, size: CGFloat?, relativeTo style: Font.TextStyle) -> Font {
    return Font.custom(customFont.rawValue, size: size ?? 16, relativeTo: style)
  }
}

#Preview {
  VStack(alignment: .leading) {
    ForEach(Font.CustomFonts.allCases, id: \.self) { sample in
      Text(sample.rawValue)
        .font(.addedFonts(sample, size: 16, relativeTo: .body))
        .padding()
    }
  }
}


// MARK: - Other

// FIXME: - Needed or not?
extension Font.TextStyle {
  var rawValue: String {
    switch self {
    case .largeTitle:
      "largeTitle"
    case .title:
      "title"
    case .title2:
      "title2"
    case .title3:
      "title3"
    case .headline:
      "headline"
    case .subheadline:
      "subheadline"
    case .body:
      "body"
    case .callout:
      "callout"
    case .footnote:
      "footnote"
    case .caption:
      "caption"
    case .caption2:
      "caption2"
    case .extraLargeTitle:
      "extraLargeTitle"
    case .extraLargeTitle2:
      "extraLargeTitle2"
    @unknown default:
      fatalError()
    }
  }
}
