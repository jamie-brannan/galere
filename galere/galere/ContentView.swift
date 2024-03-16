//
//  ContentView.swift
//  galere
//
//  Created by Jamie Brannan on 18/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationView {
        VStack {
              Image(systemName: "globe")
                  .imageScale(.large)
                  .foregroundColor(.accentColor)
              Text("Hello, Galère!")
          }
          .toolbar {
            NavigationLink(destination: FontSettingsView()) {
              Text("Temporary Settings")
            }
          }
        .padding()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
