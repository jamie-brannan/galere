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
    let fileName = "MySettings"
    let settingsUrlRaw = URL(
      fileURLWithPath: fileName,
      relativeTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    ).appendingPathExtension("json")
    /// Has this simulator already set settings or not?
    if FileManager.default.fileExists(atPath: settingsUrlRaw.path) {
      XCTAssertEqual(JsonManager.isAlreadyALocalFile(named: fileName), true)
    } else {
      XCTAssertEqual(JsonManager.isAlreadyALocalFile(named: fileName), false)
    }
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

  func testWriteUserDefaultJson() {
    let testSaveUrl = URL(
      fileURLWithPath: "UnitTest",
      relativeTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    ).appendingPathExtension("json")
    /// If there's already a test file, then this test automatically fails
    guard !FileManager.default.fileExists(atPath: testSaveUrl.path) else {
      return XCTFail("Something's happened here: perhaps the file 'UnitTest' was not deleted from the last unit test run. Try running on a different simulator")
    }
    /// This value is impossible to select from `FontSettingsView` slider limits and not in `default.json` therefore should be unique to this test
    let myTestValue = Settings(font: .micro, size: 1)
    JsonManager.writeUserDefaultJson(inFileNamed: "UnitTest", withValues: myTestValue)
    XCTAssertTrue(FileManager.default.fileExists(atPath: testSaveUrl.path))
    /// Clean up after result of assertion for next time
    try? FileManager.default.removeItem(atPath: testSaveUrl.path)
  }
}
