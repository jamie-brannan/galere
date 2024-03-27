//
//  ExternalCitationView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

struct ExternalCitationView: View {
    var body: some View {
      VStack(alignment: .leading) {
        
        HStack(alignment: .firstTextBaseline) {
          Text("Google Fonts")
            .font(.title3)
            .bold()
          Spacer()
          Text("App-wide Content Source")
            .font(.caption)
        }
        .padding(.bottom)
        
        Text("Where did you get this nice typography round here?")
          .font(.body)
        
        Label(
          title: {
            Text("This is the link here").bold()
          },
          icon: {
            Image(systemName: "link")
          }
        )
        .padding()
      }
      .padding()
      .background(
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
          .fill(.tertiary)
      )
    }
}

#Preview("External Citation View") {
    ExternalCitationView()
}
