/*
 Repositories.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
import XCTest

import SDGText
import SDGExternalProcess

import SDGSwift
import SDGSwiftPackageManager

public let thisRepository = PackageRepository(
  at: URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent()
    .deletingLastPathComponent()
)
public let mocksDirectory = thisRepository.location.appendingPathComponent("Tests/Mock Projects")

private func withMock(
  named name: String? = nil,
  dependentOn dependencies: [String] = [],
  file: StaticString = #file,
  line: UInt = #line,
  test: (URL) throws -> Void
) throws {

  var mocks: [URL] = []
  defer {
    for mock in mocks {
      try? FileManager.default.removeItem(at: mock)
    }
  }

  @discardableResult func setUpMock(named name: String) throws -> PackageRepository {
    let mock = PackageRepository(at: URL(fileURLWithPath: "/tmp/" + name))
    try? FileManager.default.removeItem(at: mock.location)
    mocks.append(mock.location)
    try FileManager.default.copy(mocksDirectory.appendingPathComponent(name), to: mock.location)
    _ = try Shell.default.run(command: ["git", "init"], in: mock.location).get()
    _ = try Shell.default.run(command: ["git", "add", "."], in: mock.location).get()
    _ = try Shell.default.run(
      command: ["git", "commit", "\u{2D}m", "Initialized."],
      in: mock.location
    ).get()
    _ = try Shell.default.run(command: ["git", "tag", "1.0.0"], in: mock.location).get()
    return mock
  }
  for dependency in dependencies {
    try setUpMock(named: dependency)
  }
  let mock: URL
  if let specific = name {
    mock = try setUpMock(named: specific).location
  } else {
    // Fixed path to prevent run‐away growth of Xcode’s derived data.
    mock = URL(fileURLWithPath: "/tmp/Mock")
    mocks.append(mock)
  }

  try test(mock)
}

public func withMock(
  named name: String,
  dependentOn dependencies: [String] = [],
  file: StaticString = #file,
  line: UInt = #line,
  test: (PackageRepository) throws -> Void
) throws {
  try withMock(named: name, dependentOn: dependencies, file: file, line: line) { url in
    try test(PackageRepository(at: url))
  }
}

#if !(os(Windows) || os(Android))  // #workaround(Swift 5.1.3, SwiftPM won’t compile.)
  public func withDefaultMockRepository(
    file: StaticString = #file,
    line: UInt = #line,
    test: (PackageRepository) throws -> Void
  ) throws {
    return try withMock(file: file, line: line) { mock in
      let repository = try PackageRepository.initializePackage(
        at: mock,
        named: StrictString(mock.lastPathComponent),
        type: .library
      ).get()
      try test(repository)
    }
  }
#endif

public func withMockDynamicLinkedExecutable(
  file: StaticString = #file,
  line: UInt = #line,
  test: (PackageRepository) throws -> Void
) throws {
  try withMock(
    named: "DynamicallyLinkedTool",
    dependentOn: ["DynamicLibraryA", "DynamicLibraryB"],
    file: file,
    line: line,
    test: test
  )
}
