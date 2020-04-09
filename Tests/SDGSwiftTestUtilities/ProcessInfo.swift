/*
 ProcessInfo.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(workspace version 0.32.1, Web lacks Foundation.)
  import Foundation

  import SDGLogic

  extension ProcessInfo {

    internal static let isInGitHubAction =
      ProcessInfo.processInfo.environment["GITHUB_ACTIONS"] ≠ nil
  }
#endif
