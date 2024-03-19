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

final class LaunchScreenStateManager: ObservableObject {
  @MainActor @Published private(set) var state: LaunchScreenStep = .start

  @MainActor func dismiss() {
    Task {
      try? await Task.sleep(for: Duration.seconds(6))
      self.state = .finish
    }
  }
}

struct LaunchScreen: View {
  var titleAnimationDuration: Double { return 1.0 }
  @State var isJumping = false

  var body: some View {
    ZStack {
      Color.green
      VStack {
        Text("Galère")
          .font(.addedFonts(.jacquarda, size: 100, relativeTo: .title))
          .offset(y: isJumping ? 0 : -80)
          .animation(.interpolatingSpring(stiffness: 1, damping: 2, initialVelocity: 0.5), value: isJumping)
        Text("We're in the same boat")
          .italic()
          .offset(y: isJumping ? 0 : +80)
          .animation(.interpolatingSpring(stiffness: 1, damping: 2, initialVelocity: 0.5), value: isJumping)
      }
      .foregroundStyle(.white)
    }.ignoresSafeArea()
      .onAppear(perform: { self.isJumping.toggle() })
  }
}

#Preview {
  LaunchScreen()
}
