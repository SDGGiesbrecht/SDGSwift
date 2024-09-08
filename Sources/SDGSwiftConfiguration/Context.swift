/*
 Context.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

/// A context provided by the configuration loader.
public protocol Context: Codable {}

extension Context {

  /// Returns the context provided by the configuration loader.
  public static func accept() -> Self? {  // @exempt(from: tests) Requires 0.1.10
    guard ProcessInfo.processInfo.arguments.count > 1 else {
      return nil
    }
    let json = ProcessInfo.processInfo.arguments[1]
    return (try? JSONDecoder().decode([Self].self, from: json.data(using: .utf8)!))?.first
  }
}
