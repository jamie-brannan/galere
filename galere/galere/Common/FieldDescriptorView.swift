//
//  FieldDescriptorView.swift
//  galere
//
//  Created by Jamie Brannan on 05/03/2024.
//

import SwiftUI

/// A subtle helpful description of what is the destination use of the field inquired
struct FieldDescriptorView<Content: View>: View {
  var description: String
  var fieldAlignment: HorizontalAlignment = .leading
  var helperTextAlignment: TextAlignment = .leading
  @ViewBuilder var field: Content

    var body: some View {
      VStack(alignment: fieldAlignment, spacing: 8) {
        HStack {
          Text(description)
            .font(.caption)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            .multilineTextAlignment(helperTextAlignment)
          Spacer()
        }
        field
      }
    }
}

#Preview("Fake 'Favorite Song' Form") {
  struct Preview: View {
    @State var temp: String = ""
    var body: some View {
      VStack(alignment: .leading) {
        Text("Favorite song")
        FieldDescriptorView(
          description: "This is your most played on your favorite music app",
          field: {
            TextField("Favorite song", text: $temp, prompt: Text("The Fear - Lily Allen"))
          }
        )
      }.padding()
    }
  }

  return Preview()
}
