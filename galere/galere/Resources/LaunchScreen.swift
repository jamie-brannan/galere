//
//  LaunchScreen.swift
//  galere
//
//  Created by Jamie Brannan on 19/03/2024.
//
import Foundation
import SwiftUI

/// The welcoming view that appears first on launch in the `WindowGroup` of ``GalereApp``
/// 
/// ## In the future
/// Networking calls can happen behind the scenes, and determine when the animations should end.
struct LaunchScreen: View {
  // MARK: - Properties

  // MARK: Constants
  let backgroundColor: Color = .green
  // TODO: Extract this font size magic number
  let displayFont: Font = .addedFonts(.jacquarda, size: 100, relativeTo: .title)

  // MARK: Animation
  // TODO: Extract this animation duration size magic number
  var titleAnimationDuration: Double { return 1.0 }
  // TODO: Extract this spring size magic numbers
  let springAnimation: Animation = .interpolatingSpring(stiffness: 1, damping: 2, initialVelocity: 0.5)

  @State var isJumping = false
  let jumpingTrue: CGFloat = 0
  let jumpingFalseWholeNumber: CGFloat = 80

  // MARK: - Layout
  var body: some View {
    ZStack {
      backgroundColor
      animatedLogoView
        .foregroundStyle(.white)
    }.ignoresSafeArea()
      .onAppear(perform: onAppear)
      .onTapGesture(count: 2) {
        onAppear()
      }
  }

  var animatedLogoView: some View {
    VStack {
      titleView
      subtitleView
    }
  }

  // MARK: - Child Views

  var titleView: some View {
    Text("Galère")
      .font(displayFont)
      .offset(y: isJumping ? jumpingTrue : -jumpingFalseWholeNumber)
      .animation(springAnimation, value: isJumping)
  }

  var subtitleView: some View {
    Text("We're in the same boat")
      .italic()
      .offset(y: isJumping ? jumpingTrue : +jumpingFalseWholeNumber)
      .animation(springAnimation, value: isJumping)
  }

  // MARK: - Actions
  func onAppear() {
    self.isJumping.toggle()
  }
}

#Preview("Launch Screen Preview") {
  LaunchScreen()
}
