//
//  FileManagerTests.swift
//  galereTests
//
//  Created by Jamie Brannan on 26/03/2024.
//

import XCTest

final class FileManagerTests: XCTestCase {

  func testDocumentsDirectoryUrl() {
    XCTAssertTrue(
      FileManager.documentsDirectoryURL == FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    )
  }

}
