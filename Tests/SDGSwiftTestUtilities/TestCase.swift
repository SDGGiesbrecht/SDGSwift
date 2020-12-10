/*
 TestCase.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import Foundation

  import SDGVersioning

  import SDGSwift

  import SDGXCTestUtilities

  open class TestCase: SDGXCTestUtilities.TestCase {

    private static let configureGit: Void = {
      #if !os(WASI)  // #workaround(Swift 5.3.1, Web lacks ProcessInfo.)
      if ProcessInfo.isInGitHubAction {
        // @exempt(from: tests)
        // #workaround(Swift 5.3.1, Segmentation fault.)
        #if !os(Windows)
          _ = try? Git.runCustomSubcommand(
            ["config", "\u{2D}\u{2D}global", "user.email", "john.doe@example.com"],
            versionConstraints: Version(0, 0, 0)..<Version(100, 0, 0)
          ).get()
          _ = try? Git.runCustomSubcommand(
            ["config", "\u{2D}\u{2D}global", "user.name", "John Doe"],
            versionConstraints: Version(0, 0, 0)..<Version(100, 0, 0)
          ).get()
        #endif
      }
      #endif
    }()
    open override func setUp() {
      super.setUp()
      TestCase.configureGit
    }
  }
