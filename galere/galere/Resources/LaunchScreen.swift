//
//  LaunchScreen.swift
//  galere
//
//  Created by Jamie Brannan on 19/03/2024.
//
import Foundation
import SwiftUI

/// Integration inspired by : https://holyswift.app/animated-launch-screen-in-swiftui/

/// Phases in animating the ``LaunchScreen``. Every animation has a start, stop and duration. These are the different stopping points on the animation journey.
enum LaunchScreenStep {
  case start
  case finish
}

/// This manager will give methods for, and publish updates, across views of the change in animation steps of the screen.
final class LaunchScreenStateManager: ObservableObject {
  @MainActor @Published private(set) var state: LaunchScreenStep = .start

  ///  The `Task` of taking the states through different time durations between the defined ``LaunchScreenStep``s till it's end.
  @MainActor func dismiss() {
    Task {
      try? await Task.sleep(for: Duration.seconds(6))
      self.state = .finish
    }
  }
}

/// The welcoming view that appears first on launch in the `WindowGroup` of ``GalereApp``
/// 
/// ## In the future
/// Networking calls can happen behind the scenes, and determine when the animations should end.
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
