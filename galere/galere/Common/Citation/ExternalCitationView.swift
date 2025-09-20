//
//  ExternalCitationView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

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
