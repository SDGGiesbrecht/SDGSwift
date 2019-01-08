/*
 ScanContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class SyntaxContext {

    // MARK: - Initialization

    internal init(fragmentContext: String, parentContext: SyntaxContext?) {
        self.fragmentContext = fragmentContext
        self.parentContext = parentContext
    }

    // MARK: - Properties

    internal var fragmentContext: String
    internal var parentContext: SyntaxContext?
}
