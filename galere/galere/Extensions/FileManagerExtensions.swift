//
//  FileManagerExtensions.swift
//  galere
//
//  Created by Jamie Brannan on 18/03/2024.
//

import Foundation

public extension FileManager {
  /// Inspired by related Kodeco tutorials coding style
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
