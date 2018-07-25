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

    private func apiChildren() -> [APIElement] {
        return Array(children.map({ $0.api() }).joined())
    }

    private func isPublic() -> Bool {
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
        case is UnknownDeclSyntax :
            search: for child in children {
                if let token = child as? TokenSyntax {
                    switch token.tokenKind {
                    case .varKeyword, .letKeyword:
                        // Variable
                        if ¬isPublic() {
                            return [] // Nothing nested is relevant.
                        } else {
                            if let nameToken = self.child(at: token.indexInParent + 1) as? TokenSyntax {
                                switch nameToken.tokenKind {
                                case .identifier(let name):
                                    var typeName: String?
                                    if let type = self.child(at: nameToken.indexInParent + 2) as? SimpleTypeIdentifierSyntax {
                                        typeName = type.name.text
                                    }
                                    var isSettable = false
                                    if token.tokenKind == .varKeyword {
                                        if ¬children.contains(where: { node in
                                            if let modifier = node as? DeclModifierSyntax {
                                                switch modifier.name.tokenKind {
                                                case .privateKeyword, .fileprivateKeyword, .internalKeyword:
                                                    return true // Reduced setter access level.
                                                default:
                                                    break
                                                }
                                            }
                                            return false
                                        }) {
                                            // No setter access reduction.

                                            if children.contains(where: { node in
                                                if let token = node as? TokenSyntax {
                                                    switch token.tokenKind {
                                                    case .unknown, // “set”
                                                        .equal: // Stored property, not computed.
                                                        return true
                                                    default:
                                                        break
                                                    }
                                                }
                                                return false
                                            }) {
                                                isSettable = true
                                            }
                                        }
                                    }
                                    return [VariableAPI(name: name, type: typeName, isSettable: isSettable)]
                                default:
                                    break
                                }
                            }
                        }
                    case .funcKeyword:
                        // Function
                        if ¬isPublic() {
                            return [] // Nothing nested is relevant.
                        } else {
                            if let nameToken = self.child(at: token.indexInParent + 1) as? TokenSyntax {
                                switch nameToken.tokenKind {
                                case .identifier(let name):
                                    print(children.map({ (type(of: $0), $0) }))
                                    let `throws` = children.contains(where: { ($0 as? TokenSyntax)?.tokenKind == .throwsKeyword })

                                    var returnType: String?
                                    for child in children {
                                        if let type = child as? SimpleTypeIdentifierSyntax {
                                            returnType = type.name.text
                                            break
                                        }
                                    }

                                    return [FunctionAPI(name: name, arguments: [], throws: `throws`, returnType: returnType)]
                                default:
                                    break
                                }
                            }
                        }
                    case .extensionKeyword:
                        // Extension
                        if let type = self.child(at: token.indexInParent + 1) as? SimpleTypeIdentifierSyntax {
                            let children = apiChildren()
                            if ¬children.isEmpty {
                                return [ExtensionAPI(type: type.name.text, children: children)]
                            }
                        }
                    default:
                        continue search
                    }
                }
            }
            return apiChildren()
        default:
            return apiChildren()
        }
    }
}
