/*
 Repositories.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation
#if !PLATFORM_LACKS_XC_TEST
  import XCTest
#endif

import SDGText
import SDGExternalProcess

import SDGSwift
import SDGSwiftPackageManager

public let thisRepository: PackageRepository = {
  var root = URL(fileURLWithPath: #filePath)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()
  #if os(Windows)
    // Fix WSL paths if cross‐compiled.
    var directory = root.path
    if directory.hasPrefix("/mnt/") {
      directory.removeFirst(5)
      let driveLetter = directory.removeFirst()
      directory.prepend(contentsOf: "\(driveLetter.uppercased()):")
      root = URL(fileURLWithPath: directory)
    }
  #endif
  if let overridden = ProcessInfo.processInfo
    .environment["SWIFTPM_PACKAGE_ROOT"]
  {  // @exempt(from: tests)
    // @exempt(from: tests)
    root = URL(fileURLWithPath: overridden)
  }
  return PackageRepository(at: root)
}()
public let mocksDirectory: URL = thisRepository.location
  .appendingPathComponent("Tests").appendingPathComponent("Mock Projects")
public let documentationTestPackages: [URL] = ["PackageToDocument", "PackageToDocument2"]
  .map { name in
    return mocksDirectory.appendingPathComponent(name)
  }

#if !PLATFORM_LACKS_FOUNDATION_FILE_MANAGER
  private func withMock(
    named name: String? = nil,
    dependentOn dependencies: [String] = [],
    file: StaticString = #filePath,
    line: UInt = #line,
    test: (URL) throws -> Void
  ) throws {

    let temporaryDirectory: URL
    #if PLATFORM_HAS_XCODE
      // Fixed path to prevent run‐away growth of Xcode’s derived data.
      temporaryDirectory = URL(fileURLWithPath: "/tmp")
    #else
      temporaryDirectory = FileManager.default.temporaryDirectory
    #endif

    var mocks: [URL] = []
    defer {
      for mock in mocks {
        try? FileManager.default.removeItem(at: mock)
      }
    }

    @discardableResult func setUpMock(named name: String) throws -> PackageRepository {
      let mock = PackageRepository(at: temporaryDirectory.appendingPathComponent(name))
      try? FileManager.default.removeItem(at: mock.location)
      mocks.append(mock.location)
      try FileManager.default.copy(mocksDirectory.appendingPathComponent(name), to: mock.location)
      #if !PLATFORM_LACKS_GIT && !os(Windows)
        var initialization = ["git", "init"]
        #if os(Linux)  // Ubuntu’s git is too old.
          initialization.append(contentsOf: [])
        #else
          initialization.append(contentsOf: ["\u{2D}\u{2D}initial\u{2D}branch", "master"])
        #endif
        _ = try Shell.default.run(
          command: initialization,
          in: mock.location
        ).get()
        _ = try Shell.default.run(command: ["git", "add", "."], in: mock.location).get()
        _ = try Shell.default.run(
          command: ["git", "commit", "\u{2D}m", "Initialized."],
          in: mock.location
        ).get()
        _ = try Shell.default.run(command: ["git", "tag", "1.0.0"], in: mock.location).get()
      #endif
      return mock
    }
    for dependency in dependencies {
      try setUpMock(named: dependency)
    }
    let mock: URL
    if let specific = name {
      mock = try setUpMock(named: specific).location
    } else {
      // @exempt(from: tests) Unreachable on tvOS.
      // Fixed path to prevent run‐away growth of Xcode’s derived data.
      mock = temporaryDirectory.appendingPathComponent("Mock")
      mocks.append(mock)
    }
    try test(mock)
  }

  public func withMock(
    named name: String,
    dependentOn dependencies: [String] = [],
    file: StaticString = #filePath,
    line: UInt = #line,
    test: (PackageRepository) throws -> Void
  ) throws {
    try withMock(named: name, dependentOn: dependencies, file: file, line: line) { url in
      try test(PackageRepository(at: url))
    }
  }

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    @available(macOS 10.15, *)
    public func withDefaultMockRepository(
      file: StaticString = #filePath,
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
    file: StaticString = #filePath,
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
#endif
