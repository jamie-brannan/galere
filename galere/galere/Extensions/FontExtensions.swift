//
//  FontExtensions.swift
//  galere
//
//  Created by Jamie Brannan on 06/03/2024.
//

import SwiftUI

// MARK: - Custom Fonts

public extension Font {
  static func jacquardaB(size: CGFloat?, relativeTo style: Font.TextStyle) -> Font {
    return Font.custom("JacquardaBastarda9-Regular", size: size ?? 16, relativeTo: style)
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
