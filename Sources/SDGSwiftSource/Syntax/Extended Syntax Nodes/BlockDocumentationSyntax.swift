/*
 BlockDocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  /// A block documentation comment.
  public final class BlockDocumentationSyntax: BlockCommentSyntax {

    // MARK: - Class Properties

    internal override class var openingDelimiter: ExtendedTokenSyntax {
      return ExtendedTokenSyntax(text: "/\u{2A}*", kind: .openingBlockDocumentationDelimiter)
    }

    internal override class func parse(contents: String) -> DocumentationSyntax {
      return DocumentationSyntax.parse(source: contents)
    }

    // MARK: - Properties

    /// The documentation content.
    public var documentation: DocumentationSyntax {
      return internalSyntax as! DocumentationSyntax
    }
  }
