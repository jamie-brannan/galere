//
//  FontSettingsView.swift
//  galere
//
//  Created by Jamie Brannan on 05/03/2024.
//

import SwiftUI

struct FontSettingsView: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 16) {
        PairingDisplayView()
        
        Divider()
        
        
      }
      .navigationTitle("Font Settings")
      .navigationBarTitleDisplayMode(.large)
    }
}

struct PairingDisplayView: View {
  @State var displaySample = "Display"
  @State var bodySample = "Body"
  
  var body: some View {
    VStack(alignment: .leading) {
      Group {
        TextField("display", text: $displaySample)
        TextField("body", text: $bodySample)
      }
      .padding()
    }
    .overlay(
      RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
        .strokeBorder()
    )
    .padding()
  }
}

#Preview {
  NavigationView {
    FontSettingsView()
  }
}
