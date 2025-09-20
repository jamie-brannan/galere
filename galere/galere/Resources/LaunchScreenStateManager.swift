//
//  LaunchScreenStateManager.swift
//  galere
//
//  Created by Jamie Brannan on 20/09/2025.
//

import Foundation

/// This manager will give methods for, and publish updates, across views of the change in animation steps of the screen.
///
/// This class is marked with the `final` keyword because we do not want it to be overriden nor subclassed, since we only have one launch screen for the app for now.
/// > For more about classes as reference types see related official Swift.org documentation: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/
///
/// Therefore we need `@MainActor` on the `state` and for the `dismiss()` that'll mutate the state so that we're sure it stays on the main thread
///  > For more info  see AvanderLee's blog post about the subject: https://www.avanderlee.com/swift/mainactor-dispatch-main-thread/
final class LaunchScreenStateManager: ObservableObject {
  // MARK: - Helper types

  /// Phases in animating the ``LaunchScreen``. Every animation has a start, stop and duration. These are the different stopping points on the animation journey.
  ///
  /// Integration inspired by : https://holyswift.app/animated-launch-screen-in-swiftui/
  enum LaunchScreenStep {
    case start
    case finish
  }


  // MARK: - Properties


  let duration: Int = 6
  @MainActor @Published private(set) var state: LaunchScreenStep = .start

  // MARK: - Action


  ///  The `Task` of taking the states through different time durations between the defined ``LaunchScreenStep``s
  @MainActor func dismiss() {
    Task {
      try? await Task.sleep(for: Duration.seconds(duration))
      self.state = .finish
    }
  }
}
