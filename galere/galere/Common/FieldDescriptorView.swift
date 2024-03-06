//
//  FieldDescriptorView.swift
//  galere
//
//  Created by Jamie Brannan on 05/03/2024.
//

import SwiftUI

struct FieldDescriptorView<Content: View>: View {
  var description: String
  @ViewBuilder var field: Content

    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        HStack{
          Spacer()
          Text(description)
            .font(.caption)
            .foregroundColor(.secondary)
            .lineLimit(0)
        }
        field
      }
      .frame(width: .infinity)
    }
}

#Preview {
  FieldDescriptorView(description: "cool will happen", field: { Text("heyeyyyeyey") } )
}
