//
//  ExternalLink.swift
//  galere
//
//  Created by Jamie Brannan on 27/03/2024.
//

import Foundation

struct ExternalLink: Hashable {
  let iconName: String
  let displayName: String
  var description: String?
  let weblink: URL
}
