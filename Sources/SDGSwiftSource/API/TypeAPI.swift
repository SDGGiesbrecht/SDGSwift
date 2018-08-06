/*
 TypeAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic

public class TypeAPI : APIScope {

    // MARK: - Initialization

    internal init(keyword: String, name: String, conformances: [ConformanceAPI], children: [APIElement]) {
        _name = name.decomposedStringWithCanonicalMapping
        self.keyword = keyword
        super.init(conformances: conformances, children: children)
    }

    // MARK: - Properties

    private let keyword: String
    private let _name: String

    // MARK: - APIElement

    public override var name: String {
        return _name
    }

    public override var declaration: String? {
        return keyword + " " + name
    }

    public override var summary: [String] {
        return [name] + scopeSummary
    }
}
