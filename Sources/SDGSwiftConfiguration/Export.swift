/*
 Export.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

public func _exportConfiguration(
  file: StaticString = #fileID,
  line: UInt = #line
) {  // @exempt(from: tests)
  // Testing occurs beyond the reach of coverage tracking.
  do {
    let json = try JSONEncoder().encode([Configuration.registered])
    print(String(data: json, encoding: .utf8)!)
  } catch {
    fatalError(error.localizedDescription, file: file, line: line)
  }
}
