/*
 SDGSwiftSourceInternalTests.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGXCTestUtilities

@testable import SDGSwiftSource

class SDGSwiftSourceInternalTests : TestCase {

    func testTokenNormalization() {
        let tokens: [TokenKind] = [
        .stringSegment("\u{C0}"),
        .dollarIdentifier("$0"),
        .unspacedBinaryOperator("=="),
        .prefixOperator("!"),
        .postfixOperator("..."),
        .integerLiteral("0"),
        .floatingLiteral("0"),
        .contextualKeyword("mutating"),
        .unknown("...")
        ]
        for kind in tokens {
            let token = SyntaxFactory.makeToken(kind)
            XCTAssert(token.generallyNormalizedAndMissingInsteadOfNil().text.scalars.elementsEqual(token.text.decomposedStringWithCanonicalMapping.scalars), "Token kind not normalized.")
        }
    }
}
