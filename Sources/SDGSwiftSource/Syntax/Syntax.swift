/*
 Syntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGPersistence

import SDGSwiftSyntaxShims

extension Syntax {

    // MARK: - Parsing

    public static func parse(_ source: String) throws -> SourceFileSyntax {
        let temporary = FileManager.default.url(in: .temporary, at: UUID().uuidString + ".swift")
        try? FileManager.default.removeItem(at: temporary)

        try source.save(to: temporary)
        defer { try? FileManager.default.removeItem(at: temporary) }

        return try Syntax.parse(temporary)
    }

    // MARK: - Properties

    public func source() -> String {
        var result = ""
        write(to: &result)
        return result
    }

    public func location(in source: String) -> Range<String.ScalarView.Index> {
        let start: String.ScalarView.Index
        if let parent = self.parent {
            var position = parent.location(in: source).lowerBound
            for index in 0 ..< indexInParent {
                let sibling = parent.child(at: index)!
                position = source.scalars.index(position, offsetBy: sibling.source().scalars.count)
            }
            start = position
        } else {
            start = source.scalars.startIndex
        }
        return start ..< source.scalars.index(start, offsetBy: self.source().scalars.count)
    }

    public func ancestors() -> AnySequence<Syntax> {
        if let parent = self.parent {
            return AnySequence(sequence(first: parent, next: { $0.parent }))
        } else {
            return AnySequence([])
        }
    }

    // MARK: - API

    internal func apiChildren() -> [APIElement] {
        return Array(children.map({ $0.api() }).joined())
    }

    internal func isPublic() -> Bool {
        return children.contains(where: { node in
            if let modifier = node as? DeclModifierSyntax,
                modifier.name.tokenKind == .publicKeyword {
                return true
            }
            return false
        })
    }

    // @documentation(SDGSwiftSource.Syntax.api())
    /// Returns the API provided by this node.
    public func api() -> [APIElement] {
        switch self {
        case let unknown as UnknownDeclSyntax :
            if unknown.isVariableSyntax {
                return unknown.variableAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isFunctionSyntax {
                return unknown.functionAPI.flatMap({ [$0] }) ?? []
            } else if unknown.isExtensionSyntax {
                return unknown.extensionAPI.flatMap({ [$0] }) ?? []
            } else {
                return apiChildren()
            }
        default:
            return apiChildren()
        }
    }

    // MARK: - Argument List API

    internal var argumentListAPI: [ArgumentAPI] {
        var arguments: [ArgumentAPI] = []
        for child in children {
            if let argument = child.argumentAPI {
                arguments.append(argument)
            }
        }
        return arguments
    }

    // MARK: - Argument API

    internal var argumentAPI: ArgumentAPI? {
        print(children.map({ (type(of: $0), $0) }))
        return ArgumentAPI(label: nil, name: "...", type: "...")
    }
}
