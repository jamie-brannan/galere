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
  @ObservedObject var settingsStore: SettingsStore

  @State var displayStyle: Font.TextStyle = .title
  // FIXME: these two selection default values are never used, how can I set up the init right for these to never be set and immediately erased?
  @State var fontSelection: Font.CustomFonts = .jacquarda

  @State var sizeSelection: CGFloat = 12
  let maximumSize: CGFloat = 96
  let minimumSize: CGFloat = 12

  @State var isEditing = false

  init(settingsStore: SettingsStore) { self.settingsStore = settingsStore }

  // TODO: Extract views to simplify body
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {

      // MARK: - Editable Preview
      PairingDisplayView(
        displayStyle: displayStyle,
        fontSelection: $fontSelection,
        sizeSelection: $sizeSelection
      )
      .padding()

      Divider()

      // MARK: - Fields
      ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 16) {

          Text("Headers")
            .font(.title2)
            .bold()

          VStack(alignment: .leading) {

            Text(
              String(localized: "Font Family", comment: "Field name for the font file selector")
            )

            FieldDescriptorView(
              description: "Pick font file that'll be visible in all your titles",
              field: {

                Picker("Font Selection", selection: $fontSelection) {
                  ForEach(Font.CustomFonts.allCases, id: \.self) { font in
                    Text(font.rawValue).tag(font)
                  }
                }
                .onChange(of: fontSelection) { selection in
                  settingsStore.settings.font = selection
                }
                .padding()
                .overlay(
                  RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .strokeBorder()
                    .foregroundColor(.gray)
                )
              }
            )
          }

          FieldDescriptorView(
            description: String(
              localized: "Set your relative size for the font, DynamicType's `.title` will handle the rest of scaling changes if you adjust your system settings in the meantime",
              comment: "Field description for font size"
            ),
            field: {

              VStack {

                Slider(
                  value: $sizeSelection,
                  in: minimumSize...maximumSize,
                  step: 1,
                  label: {},
                  minimumValueLabel: {

                    Text(

                      String(
                        localized: "\(minimumSize.formatted())",
                        comment: "The minimum numerical value for display fonts slider"
                      )
                    )
                  },

                  maximumValueLabel: {
                    Text(
                      String(
                        localized: "\(maximumSize.formatted())",
                        comment: "The maximumSize numerical value for display fonts slider"
                      )
                    )
                  },
                  onEditingChanged: { editing in
                    isEditing = editing
                  }
                )
                .accentColor( isEditing ? .pink : .blue)
                .onChange(of: sizeSelection) { selection in
                  settingsStore.settings.size = selection
                }

                Text("\(sizeSelection.formatted())")
                  .accentColor( isEditing ? .pink : .primary)

              }
              .padding()
              .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                  .strokeBorder()
                  .foregroundColor(.gray)
              )
            }
          )

          Divider()

          Text("Body")
            .font(.title2)
            .bold()

          Text("""
This is fixed by default to Apple's `.body` text. For more information consult Apple's Human Interface Guidelines and Apple technical documentation. \n\nAdditionally, there's the possibility to adjust your system base font size settings by going to the `System` app >
""") // TODO: Finish string

        }
        .padding()
      }
      
      Spacer()
    }
    .navigationTitle("Font Settings")
    .navigationBarTitleDisplayMode(.large)
    .onAppear(perform: {
      fontSelection = settingsStore.settings.font
      sizeSelection = settingsStore.settings.size
    })
  }
}

#Preview("Font Settings View") {
  NavigationView {
    FontSettingsView(settingsStore: SettingsStore())
  }
}

/// The editable text area view that provides a neutral preview of uniquely the fonts
struct PairingDisplayView: View {
  var displayStyle: Font.TextStyle
  @Binding var fontSelection: Font.CustomFonts
  @Binding var sizeSelection: CGFloat

  var font: Font {
    .addedFonts(fontSelection, size: sizeSelection, relativeTo: displayStyle)
  }

  @State var displaySample = "Tap to edit the display"
  @State var bodySample = "Tap to write a new body"

  var body: some View {
    VStack(alignment: .leading) {
      Group {
        TextField(
          "display",
          text: $displaySample
        )
        .font(font)
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
        .foregroundColor(.cyan)
    )
    .padding()
  }
}
