/*
 DocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGMathematics
import SDGCMarkShims

private var documentationCache: [String: DocumentationSyntax] = [:]

public class DocumentationSyntax : MarkdownSyntax {

    internal static func parse(source: String) -> DocumentationSyntax {
        let result = cached(in: &documentationCache[source]) {
            return DocumentationSyntax(source: source)
        }
        if documentationCache.underestimatedCount ≥ 100 {
            documentationCache = [:] // @exempt(from: tests)
        }
        return result
    }

    // MARK: - Initialization

    private init(source: String) {
        var cSource = source.cString(using: .utf8)!
        cSource.removeLast() // Remove trailing NULL.
        let tree = cmark_parse_document(cSource, cSource.count, CMARK_OPT_DEFAULT)
        defer { cmark_node_free(tree) }
        super.init(node: tree, in: source)

        for child in children {
            if let paragraph = child as? ParagraphSyntax, descriptionSection == nil { // @exempt(from: tests) False coverage result in Xcode 9.4.1.
                descriptionSection = paragraph
            } else if let calloutSyntax = child as? CalloutSyntax,
                let callout = Callout(calloutSyntax.name.text) {
                switch callout {
                case .parameters:
                    parameters = calloutSyntax
                case .parameter:
                    separateParameterEntries.append(calloutSyntax)
                case .throws:
                    throwsCallout = calloutSyntax
                case .returns:
                    returnsCallout = calloutSyntax
                case .localizationKey, .keyword, .recommended, .recommendedOver:
                    break
                default:
                    discussionEntries.append(child)
                }
            } else {
                discussionEntries.append(child)
            }
        }
    }

    // MARK: - Properties

    public private(set) var descriptionSection: ParagraphSyntax?

    public private(set) var discussionEntries: [ExtendedSyntax] = []

    private var parameters: CalloutSyntax?
    private var separateParameterEntries: [CalloutSyntax] = []
    public var normalizedParameters: [(parameter: ExtendedTokenSyntax, description: [ExtendedSyntax])] {
        if let parameters = self.parameters {
            #warning("Not implemented yet.")
            return []
        } else {
            return separateParameterEntries.map { entry in
                return (parameter: entry.parameterName ?? ExtendedTokenSyntax(text: "", kind: .parameter), description: entry.contents)
            }
        }
    }

    public private(set) var throwsCallout: CalloutSyntax?

    public private(set) var returnsCallout: CalloutSyntax?
}
