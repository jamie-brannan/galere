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
///
/// This class is marked with the `final` keyword because we do not want it to be overriden nor subclassed, since we only have one launch screen for the app for now.
/// > For more about classes as reference types see related official Swift.org documentation: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/
///
/// Therefore we need `@MainActor` on the `state` and for the `dismiss()` that'll mutate the state so that we're sure it stays on the main thread
///  > For more info  see AvanderLee's blog post about the subject: https://www.avanderlee.com/swift/mainactor-dispatch-main-thread/
final class LaunchScreenStateManager: ObservableObject {
  @MainActor @Published private(set) var state: LaunchScreenStep = .start

  ///  The `Task` of taking the states through different time durations between the defined ``LaunchScreenStep``s
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

#Preview("Launch Screen Preview") {
  LaunchScreen()
}
