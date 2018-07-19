/*
 CommentSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic
import SDGLocalization

public class CommentContentSyntax : ExtendedSyntax {

    // MARK: - Initialization

    internal init(source: String) {
        var source = source
        var children: [ExtendedSyntax] = []

        for lineInfo in source.lines {
            if ¬lineInfo.line.isEmpty {
                var line = String(lineInfo.line)

                while let `protocol` = line.scalars.firstMatch(for: "://".scalars)?.range {
                    let start = line.scalars.lastMatch(for: " ".scalars, in: line.startIndex ..< `protocol`.lowerBound)?.range.upperBound ?? line.startIndex
                    let end = line.scalars.firstMatch(for: " ".scalars, in: `protocol`.upperBound ..< line.scalars.endIndex)?.range.lowerBound ?? line.endIndex

                    if start ≠ line.startIndex {
                        children.append(ExtendedTokenSyntax(text: String(line[..<start]), kind: .commentText))
                    }
                    children.append(ExtendedTokenSyntax(text: String(line[start..<end]), kind: .commentURL))
                    line.scalars.removeSubrange(line.scalars.startIndex ..< end)
                }

                if ¬line.isEmpty {
                    children.append(ExtendedTokenSyntax(text: line, kind: .commentText))
                }
            }
            if ¬lineInfo.newline.isEmpty {
                children.append(ExtendedTokenSyntax(text: String(lineInfo.newline), kind: .newlines))
            }
        }

        super.init(children: children)
    }
}
