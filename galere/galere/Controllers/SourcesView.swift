//
//  SourcesView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

struct SourcesView: View {
    var body: some View {
      VStack(alignment: .leading) {
        List {
          Section(header: Text("Assets")) {
            Text("Other")
          }
          Section(header: Text("Programming Best Practices")) {
            Text("Other")
          }
        }
      }
    }
}

#Preview {
    SourcesView()
}
