/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension TriviaPiece {

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }

    public var textFreedom: SyntaxElement.TextFreedom {
        switch self {
        case .spaces, .tabs, .verticalTabs, .formfeeds:
            return .arbitrary
        case .newlines:
            return .invariable
        case .backticks:
            return .invariable
        case .lineComment, .blockComment:
            return .arbitrary
        case .docLineComment, .docBlockComment:
            return .arbitrary
        }
    }
}
