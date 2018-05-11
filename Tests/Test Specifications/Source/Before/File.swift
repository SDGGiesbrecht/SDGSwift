/*
 File.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

struct Structure {

    // MARK: - Initialization

    init(property: Bool) {
        self.property = property
    }

    // MARK: - Properties

    var property: Bool

    // MARK: - Methods

    func performAction() {
        property = true
    }
}
