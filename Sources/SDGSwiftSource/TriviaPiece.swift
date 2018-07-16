/*
 TriviaPiece.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

extension TriviaPiece {

    public var syntax: TriviaPieceSyntax {
        return TriviaPieceSyntax.parse(self)
    }

    public var text: String {
        var result = ""
        write(to: &result)
        return result
    }
}
