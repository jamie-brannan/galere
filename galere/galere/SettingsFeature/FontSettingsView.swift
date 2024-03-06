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
  @State var displayStyle: Font = .title
  
    var body: some View {
      VStack(alignment: .leading, spacing: 16) {

        // MARK: - Editable Preview
        PairingDisplayView(
          displayStyle: $displayStyle
        )

        Divider()

        // MARK: - Fields
        VStack(alignment: .leading, spacing: 24) {
          
          Text("Headers")
            .font(.title2)
          
          FieldDescriptorView(
            description: "Chose an Apple Text Style",
            field: {
              Text("placeholder for selector field")
            }
          )
          
          FieldDescriptorView(
            description: "Pick font file",
            field: {
              Text("placeholder for selector field")
            }
          )
          
          Text("Body")
            .font(.title2)
        }
        .padding()
        Spacer()
      }
      // TODO: Add a save button in the navbar
      // ? : - What should I do for saving settings like font and beyond? Preloaded selectable parings then user defaults right?
      .navigationTitle("Font Settings")
      .navigationBarTitleDisplayMode(.large)
    }
}
#Preview {
  NavigationView {
    FontSettingsView()
  }
}

/// The editable text area view that provides a neutral preview of uniquely the fonts
struct PairingDisplayView: View {
  @Binding var displayStyle: Font
  @State var displaySample = "Display"
  @State var bodySample = "Body"
  
  var body: some View {
    VStack(alignment: .leading) {
      Group {
        TextField(
          "display",
          text: $displaySample
        )
        .font(displayStyle)
        TextField(
          "body",
          text: $bodySample
        )
        .font(.body)
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
  PairingDisplayView(
    displayStyle: .constant(.largeTitle)
  )
}
