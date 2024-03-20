//
//  FileManagerExtensions.swift
//  galere
//
//  Created by Jamie Brannan on 18/03/2024.
//

import Foundation

public extension FileManager {
  /// Inspired by related Kodeco tutorials coding style, this is the root of the users data written on their desk related to Galère
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
