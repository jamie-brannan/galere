//
//  JsonCodables.swift
//  galere
//
//  Created by Jamie Brannan on 20/03/2024.
//

import Foundation

final class JsonManager {
  /// Singletons
  static let decoder = JSONDecoder()
  static let encoder = JSONEncoder()

  static func isAlreadyALocalFile(named name: String) -> Bool {
    let saveUrl = URL(fileURLWithPath: name, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    return FileManager.default.fileExists(atPath: saveUrl.path)
  }

  static func loadBackupJsonFor<T: Decodable>(model type: T.Type, from resource: String) -> T? {
    guard let taskJsonUrl = Bundle.main.url(forResource: resource, withExtension: "json") else { return nil }

    do {
      let taskData = try Data(contentsOf: taskJsonUrl)
      let task = try decoder.decode(type, from: taskData)
      return task
    } catch let error {
      print(error) // TODO: Avoid in prod
      return nil
    }
  }

  static func loadUserDefaultJson<T: Decodable>(named name: String, forType type: T.Type) -> T? {
    let saveUrl = URL(fileURLWithPath: name, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    do {
      let taskData = try Data(contentsOf: saveUrl)
      let task = try decoder.decode(T.self, from: taskData)
      return task
    } catch let error {
      print(error) // TODO: Avoid in prod
      return nil
    }
  }

  static func writeUserDefaultJson<T: Encodable>(inFileNamed name: String, withValues value: T) {
    do {
      let taskData = try encoder.encode(value)
      try taskData.write(to: URL(fileURLWithPath: name, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json"))
    } catch let error {
      print(error) // TODO: Avoid in prod
    }
  }
}
