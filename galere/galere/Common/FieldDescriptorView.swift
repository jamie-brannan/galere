//
//  FieldDescriptorView.swift
//  galere
//
//  Created by Jamie Brannan on 05/03/2024.
//

import SwiftUI

struct FieldDescriptorView<Content: View>: View {
  var description: String
  var fieldAlignment: HorizontalAlignment = .leading
  var helperTextAlignment: TextAlignment = .trailing
  @ViewBuilder var field: Content

    var body: some View {
      VStack(alignment: fieldAlignment, spacing: 8) {
        HStack{
          Spacer()
          Text(description)
            .font(.caption)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(nil)
            .multilineTextAlignment(helperTextAlignment)
        }
        field
      }
    }
}

#Preview {
  FieldDescriptorView(description: "cool will happen again again again again again again again again again again again again again again", field: { Text("What could we put here eh?") } )
}
