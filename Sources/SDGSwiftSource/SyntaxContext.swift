/*
 SyntaxContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

public class SyntaxContext {

    // MARK: - Initialization

    internal init(fragmentContext: String, fragmentOffset: Int, parentContext: (code: CodeFragmentSyntax, context: ExtendedSyntaxContext)?) {
        self.fragmentContext = fragmentContext
        self.fragmentOffset = fragmentOffset
        self.parentContext = parentContext
    }

    // MARK: - Properties

    internal let fragmentContext: String
    internal let fragmentOffset: Int
    internal let parentContext: (code: CodeFragmentSyntax, context: ExtendedSyntaxContext)?

    public func isFragmented() -> Bool {
        return parentContext ≠ nil
    }
}
