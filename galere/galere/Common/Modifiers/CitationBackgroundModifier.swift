//
//  CitationBackgroundModifier.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

struct CitationBackgroundModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .padding()
      .background(
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
          .fill(.tertiary)
      )
  }
}

#Preview {
  Text("Hello World")
    .modifier(CitationBackgroundModifier())
}
