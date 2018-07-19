/*
 CMarkNode.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCMarkShims

internal typealias cmark_node = OpaquePointer?

extension CMark {

    internal class Node {

        // MARK: - Initialization

        init(prexisting: cmark_node) {
            self.node = prexisting
        }

        deinit {
            cmark_node_free(node)
        }

        // MARK: - Properties

        private var node: cmark_node
    }
}
