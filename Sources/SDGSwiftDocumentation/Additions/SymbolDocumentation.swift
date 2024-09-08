/*
 SymbolDocumentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SymbolKit

/// Symbol documentation.
public struct SymbolDocumentation {

  /// Creates symbol documentation.
  ///
  /// - Parameters:
  ///   - developerComments: Any preceding developer comments.
  ///   - documentationComment: The documentation comment itself.
  public init(
    developerComments: SymbolGraph.LineList,
    documentationComment: SymbolGraph.LineList
  ) {
    self.developerComments = developerComments
    self.documentationComment = documentationComment
  }

  // MARK: - Properties

  /// Any developer line comments preceding the documentation.
  ///
  /// These are included for use by custom tools that wish to extend the documentation functionality directly supported by Swift.
  public var developerComments: SymbolGraph.LineList

  /// The documentation itself.
  public var documentationComment: SymbolGraph.LineList
}
