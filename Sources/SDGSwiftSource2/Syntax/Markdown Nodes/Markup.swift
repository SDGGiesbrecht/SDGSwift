/*
 Markup.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Markdown

extension Markup {

  /// The node’s source text.
  public var text: String {
    switch self {
    case let text as Text:
      return text.string
    default:
      #warning("Not implemented yet.")
      print("Not implemented yet: \(type(of: self))")
      return ""
    }
  }
}
