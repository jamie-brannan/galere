//
//  SourcesView.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import SwiftUI

/// Because this project is build on open-source code, articles and knowledge-sharing of all kinds, the legal and right things to do is share these resources in a clear, tracable and organized manner.
struct SourcesView: View {
  // MARK: - Layout

  var body: some View {
    VStack(alignment: .leading) {
      sourceListView
    }
    .navigationTitle(Text("Sources Cited"))
//    .navigationSubtitle("Version 1.0.0") // ???: Consider making an iOS 26 variant?
  }

  var sourceListView: some View {
    List {
      assetSectionView
      bestPracticesSectionView
    }
  }

  // MARK: - Sections

  var assetSectionView: some View {
    Section(header: assetSectionTileView) {
      // TODO: figure out an efficient and extendable/maintainable storage solution for this information
      ExternalCitationView(source: fontSource)
    }
  }

  var bestPracticesSectionView: some View {
    Section(header: bestPracticesSectionTileView) {
      Text("Other")
    }
  }

  // MARK: - Child View

  var assetSectionTileView: some View {
    Text("Assets")
  }

  var bestPracticesSectionTileView: some View {
    Text("Programming Best Practices")
  }
}

#Preview {
  SourcesView()
}

// TODO: Add french locale and dark mode previews
