/*
 TypeIdentifier.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

/// A type identifier.
public class TypeIdentifier : AtomicSyntaxElement {

    // MARK: - Initialization

    internal init(range: Range<String.ScalarView.Index>, isDefinition: Bool) {
        self.isDefinition = isDefinition
        super.init(range: range)
    }

    /// :nodoc:
    public required init(range: Range<String.ScalarView.Index>) {
        // Should never need splitting anyway.
        self.isDefinition = false
        super.init(range: range)
    }

    // MARK: - Properties

    public private(set) var isDefinition: Bool

    // [_Inherit Documentation: SyntaxElement.textFreedom_]
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return isDefinition ? .arbitrary : .aliasable
    }
}
