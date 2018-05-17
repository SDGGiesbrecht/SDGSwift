/*
 SyntaxElementDeepIterator.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension SyntaxElement {

    /// A type which provides a deep iteration interface for syntax elements.
    public class DeepIterator : IteratorProtocol, Sequence {

        // MARK: - Initialization

        internal init(rootElement: SyntaxElement) {
            element = rootElement
            if let root = rootElement as? ContainerSyntaxElement {
                childrenIterator = root.children.makeIterator() // [_Exempt from Test Coverage_] False coverage result in Xcode 9.3.
            } else {
                childrenIterator = [].makeIterator()
            }
        }

        // MARK: - Properties

        private let element: SyntaxElement
        private var returnedSelf: Bool = false
        private var childrenIterator: Array<SyntaxElement>.Iterator
        private var currentChildIterator: DeepIterator?

        // MARK: - IteratorProtocol

        /// Advances to the next element and returns it, or `nil` if no next element exists.
        public func next() -> SyntaxElement? {
            if ¬returnedSelf {
                returnedSelf = true
                return element
            } else if let nested = currentChildIterator?.next() {
                return nested
            } else {
                currentChildIterator = childrenIterator.next()?.makeDeepIterator()
                return currentChildIterator?.next()
            }
        }
    }
}
