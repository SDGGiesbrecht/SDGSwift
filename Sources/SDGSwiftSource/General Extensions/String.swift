/*
 String.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic

extension String {

  internal func warnUnidentified(
    file: StaticString = #file,
    function: StaticString = #function
  ) {  // @exempt(from: tests)
    #if DEBUG
      if first ≠ "_" {
        let fileName = URL(fileURLWithPath: "\(file)").deletingPathExtension().lastPathComponent
        print("Unidentified token: \(self) (\(fileName).\(function))")
      }
    #endif
  }
}
