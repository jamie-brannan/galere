//
//  LaunchScreen.swift
//  galere
//
//  Created by Jamie Brannan on 19/03/2024.
//
import Foundation
import SwiftUI

/// Integration inspired by : https://holyswift.app/animated-launch-screen-in-swiftui/

enum LaunchScreenStep {
  case start
  case finish
}

final class LaunchScreenStateManager: ObservableObject, Observable {
  @MainActor @Published private(set) var state: LaunchScreenStep = .start

  @MainActor func dismiss() {
    Task {
      try? await Task.sleep(for: Duration.seconds(1))
      self.state = .finish
    }
  }
}

struct LaunchScreen: View {
  var body: some View {
    ZStack {
      Color.mint
      Text("Galère")
        .font(.addedFonts(.jacquarda, size: 100, relativeTo: .title))
    }.ignoresSafeArea()
  }
}

#Preview {
  LaunchScreen()
}
