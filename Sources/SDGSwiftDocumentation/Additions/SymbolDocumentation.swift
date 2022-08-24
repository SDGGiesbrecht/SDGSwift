/*
 SymbolDocumentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

/// Symbol documentation.
public struct SymbolDocumentation {

  internal init(_ documentation: SymbolGraph.LineList) {
    self.documentationComment = documentation
  }

  // MARK: - Properties

  /// Any developer line comments preceding the documentation.
  ///
  /// These are included for use by custom tools that wish to extend the documentation functionality directly supported by Swift.
  public var developerComments: [SymbolGraph.LineList] = []

  /// The documentation itself.
  public var documentationComment: SymbolGraph.LineList
}
