//
//  ExternalLinkView.swift
//  galere
//
//  Created by Jamie Brannan on 20/09/2025.
//

import SwiftUI

/// When a link leads outside of the Galère App (web, deeplink)
struct ExternalLinkView: View, Identifiable {
  @Environment(\.openURL) var openUrl
  let id = UUID()
  let source: ExternalLink

  var body: some View {
    Button(
      action: {
        if let url = source.weblink {
          openUrl(url)
        }
      },
      label: {
        Label(
          title: {
            VStack(alignment: .leading) {
              Text(source.displayName)
              if let description = source.description {
                Text(description)
                  .font(.caption)
              }
            }
          },
          icon: {
            Image(systemName: source.iconName)
              .foregroundColor(.blue)
          }
        )
      }
    )
    .foregroundColor(.primary)
  }
}

#Preview("Default") {
  ExternalLinkView(
    source: ExternalLink(
      iconName: "link",
      displayName: "Apple Developer",
      description: "Catalogue of developer info yo, get on it!",
      weblink: URL(string: "https://developer.apple.com")
    )
  )
}

// ???: Why is my preview device not becoming one in darkmode?
#Preview("Dark mode") {
  VStack {
    ExternalLinkView(
      source: ExternalLink(
        iconName: "link",
        displayName: "Apple Developer",
        description: "Catalogue of developer info yo, get on it!",
        weblink: URL(string: "https://developer.apple.com")
      )
    )
  }
  .colorScheme(.dark)
}
