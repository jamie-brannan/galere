//
//  ExternalCitationView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

struct ExternalLinkView: View {
  let source: ExternalLink

  var body: some View {
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
      }
    )
  }
}

#Preview("External Link View") {
  ExternalLinkView(
    source: ExternalLink(
      iconName: "link",
      displayName: "Apple Developer",
      description: "Catalogue of developer info yo, get on it!",
      weblink: URL(string: "https://developer.apple.com")!
    )
  )
}

struct ExternalCitationView: View {
  let source: SourceCited

    var body: some View {
      VStack(alignment: .leading) {

        HStack(alignment: .firstTextBaseline) {
          Text("Google Fonts")
            .font(.title3)
            .bold()
          Spacer()
          Text("App-wide Content Source")
            .font(.caption)
        }
        .padding(.bottom)

        Text("Where did you get this nice typography round here?")
          .font(.body)

        ForEach(source.links, id: \.self) { link in
          ExternalLinkView(source: link)
            .padding()
        }
      }
      .padding()
      .background(
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
          .fill(.tertiary)
      )
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
            displayName: "Apple Developer",
            description: "Catalogue of developer info yo, get on it!",
            weblink: URL(string: "https://developer.apple.com")!
          )
        ]
      )
    )
}
