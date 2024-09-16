//
//  JsonCodables.swift
//  galere
//
//  Created by Jamie Brannan on 20/03/2024.
//

import Foundation

/// Anything required our application to create, read, update, or delete (CRUD) the data format known as JSON is found here
final class JsonManager {
  /// Singletons
  static let decoder = JSONDecoder()
  static let encoder = JSONEncoder()

  /// This will return a `true` or `false` response to the statement named of the function. The `LocalFile` is refering to the space on the system that is reserved for the user's data that's written locally to their device (aka `UserDefault`s) which we have nicknamed the ``documentsDirectoryURL``
  static func isAlreadyALocalFile(named name: String) -> Bool {
    let saveUrl = URL(fileURLWithPath: name, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    return FileManager.default.fileExists(atPath: saveUrl.path)
  }

  /// If there is no local file, we will use this task to decode the default settings hardcoded in JSON format in our application bundle, returning whatever "generic" `T` (for type, as long as it's `Decodable`)
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

  /// If there is a local file saved, we will decode what the application has saved from `FontSettingsView` in it's JSON format
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

  /// The user has decided change settings to a value that are are different from `default.json` in `FontSettingsView` so we will write it to the disk storage of their device
  static func writeUserDefaultJson<T: Encodable>(inFileNamed name: String, withValues value: T) {
    do {
      let taskData = try encoder.encode(value)
      try taskData.write(to: URL(fileURLWithPath: name, relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json"))
    } catch let error {
      print(error) // TODO: Avoid in prod
    }
  }
}
