//
//  ExternalCitationView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
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

#Preview("External Link View") {
  ExternalLinkView(
    source: ExternalLink(
      iconName: "link",
      displayName: "Apple Developer",
      description: "Catalogue of developer info yo, get on it!",
      weblink: URL(string: "https://developer.apple.com")
    )
  )
}

struct ExternalCitationView: View {
  let source: SourceCited

    var body: some View {
      VStack(alignment: .leading) {

        HStack(alignment: .firstTextBaseline) {
          Text(source.name)
            .font(.title3)
            .bold()
          Spacer()
          Text(source.category)
            .font(.caption)
        }
        .padding(.bottom)

        Text(source.description)
          .font(.body)

        ForEach(source.links, id: \.id) { link in
          ExternalLinkView(source: link)
            .padding()
        }
      }
    }
}

#Preview("External Citation View") {
    ExternalCitationView(
      source: SourceCited(
        name: "Google Fonts",
        category: "App-wide Content Source",
        description: "Where did you get this nice typography round here?",
        links: [
          ExternalLink(
            iconName: "link",
            displayName: "Hacking Swift",
            description: "Catalogue of developer info yo, get on it!",
            weblink: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui/how-to-open-web-links-in-safari")
          ),
          ExternalLink(
            iconName: "link",
            displayName: "Apple Developer",
            description: "Catalogue of developer info yo, get on it!",
            weblink: URL(string: "https://developer.apple.com")
          ),
          ExternalLink(
            iconName: "link",
            displayName: "Something Else",
            description: "Catalogue of developer info yo, get on it!",
            weblink: URL(string: "https://developer.apple.com")
          )
        ]
      )
    )
}
