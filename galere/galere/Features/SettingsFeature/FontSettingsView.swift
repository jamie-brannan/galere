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
  @State var isEditing = false

  init(settingsStore: SettingsStore) { self.settingsStore = settingsStore }

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
          VStack(alignment: .leading, spacing: 24) {

            Text("Headers")
              .font(.title2)
              .bold()

            FieldDescriptorView(
              description: "Pick font file that'll be visible in all your titles",
              field: {
                Picker("fontSelection", selection: $fontSelection) {
                  ForEach(Font.CustomFonts.allCases, id: \.self) { font in
                    Text(font.rawValue).tag(font)
                  }
                }
                .pickerStyle(.wheel)
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

            FieldDescriptorView(
              description: "Set your relative size for the font, DynamicType's `.title` will handle the rest",
              field: {
                VStack {
                  // TODO: Change color on slider activation
                  Slider(
                    value: $sizeSelection, 
                    in: 12...96,
                    step: 1,
                    label: {},
                    minimumValueLabel: {
                      Text("12")
                    },
                    maximumValueLabel: {
                      Text("96")
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

            FieldDescriptorView(
              description: "Pick font file",
              field: {
                Text("placeholder for selector field")
              }
            )

            FieldDescriptorView(description: "Apple Text Style", field: {
              Text("""
  This is fixed by default to Apple's `.body` text. For more information consult Apple's Human Interface Guidelines and Apple technical documentation. \n\nAdditionally, there's the possibility to adjust your system base font size settings by going to the `System` app >
  """)
              // TODO: Add info plus bubble about the system config
            })
          }
          .padding()
        }

        Spacer()
      }
      // TODO: Add a save button in the navbar
      // ? : - What should I do for saving settings like font and beyond? Preloaded selectable parings then user defaults right?
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
