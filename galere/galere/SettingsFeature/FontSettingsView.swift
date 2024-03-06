//
//  FontSettingsView.swift
//  galere
//
//  Created by Jamie Brannan on 05/03/2024.
//

import SwiftUI

/// The display of and presentation of options that are editable to create a coherent ergonomic and personalized text view.
///  - Parameters:
///    - displayStyle: Range of Font.TextStyle that Apple makes that complements the default body style

///  - Returns: An interactive control center for font calibration while remaining coherent with Dynamic Type standards
///
struct FontSettingsView: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 16) {
        PairingDisplayView()
        
        Divider()
        
        
      }
      // TODO: Add a save button in the navbar
      // QUESTION : What should I do for saving settings like font and beyond? Preloaded selectable parings then user defaults right?
      .navigationTitle("Font Settings")
      .navigationBarTitleDisplayMode(.large)
    }
}

/// The editable text area view that provides a neutral preview of uniquely the fonts
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
