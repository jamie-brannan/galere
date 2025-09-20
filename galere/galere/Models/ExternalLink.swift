//
//  ExternalLink.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import Foundation

struct ExternalLink: Identifiable, Hashable, Equatable {
  let id = UUID()
  let iconName: String
  let displayName: String
  var description: String?
  let weblink: URL?

  init(iconName: String = "link", displayName: String, description: String? = nil, weblink: URL?) {
    self.iconName = iconName
    self.displayName = displayName
    self.description = description
    self.weblink = weblink
  }
}
