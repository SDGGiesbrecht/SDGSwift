/*
 Version.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2021–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

import SDGExternalProcess
import SDGVersioning

extension Version {

  #if !PLATFORM_LACKS_FOUNDATION_PROCESS
    internal init?(inVersionQueryOutput versionQueryOutput: String, of tool: String) {
      var output = versionQueryOutput
      if tool == "swift" {
        if output.hasPrefix("swift\u{2D}driver") {
          // @exempt(from: tests) Does not occur on all platforms.
          output.drop(upTo: "Apple Swift version")
        }
      }
      self.init(firstIn: output)
    }
  #endif
}
