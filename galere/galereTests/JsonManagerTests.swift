//
//  JsonManagerTests.swift
//  galereTests
//
//  Created by Jamie Brannan on 25/03/2024.
//
@testable import galere
import XCTest

final class JsonManagerTests: XCTestCase {

  /// Do note that the simulator this has run on needs to have already had an interaction that creates a user Default for this to succeed.
  /// In other words, unit tests cannot be run on a completely fresh simulator. Best to be the simulator some functional testing and development work has been run on.
  func testIsAlreadyALocalFile() {
    XCTAssertEqual(JsonManager.isAlreadyALocalFile(named: "MySettings"), true)
    /// These json files fail because they're in the app bundle, not the `FileManager.documentsDirectoryURL`
    XCTAssertEqual(JsonManager.isAlreadyALocalFile(named: "test-json-manager"), false)
    XCTAssertEqual(JsonManager.isAlreadyALocalFile(named: "default"), false)
  }

  func testLoadingBackUpJson() {
    let expected = Settings(font: .chewy, size: 48.0)
    /// This returns nothing, cause the json file name doesn't exist in the bundle
    XCTAssertNil(JsonManager.loadBackupJsonFor(model: Settings.self, from: "name-that-does-not-exist"))
    // FIXME: There's probably a better way to do this without getting the `expected to be an instance of a class or class-constrained type` error for `Settings` model
    let loadedBackUp = JsonManager.loadBackupJsonFor(model: Settings.self, from: "default")
    XCTAssertTrue(loadedBackUp?.font == expected.font)
    XCTAssertTrue(loadedBackUp?.size == expected.size)
  }
}
