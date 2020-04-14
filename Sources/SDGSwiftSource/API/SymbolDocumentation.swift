/*
 SymbolDocumentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.2.1, SwiftSyntax won’t compile.)
#if !(os(Windows) || os(WASI) || os(Android))
  /// Symbol documentation.
  public struct SymbolDocumentation {

    internal init(_ documentation: DocumentationSyntax) {
      self.documentationComment = documentation
    }

    // MARK: - Properties

    /// Any developer line comments preceding the documentation.
    ///
    /// These are included for use by custom tools that wish to extend the documentation functionality directly supported by Swift.
    public internal(set) var developerComments: [LineDeveloperCommentSyntax] = []

    /// The documentation itself.
    public let documentationComment: DocumentationSyntax
  }
#endif
