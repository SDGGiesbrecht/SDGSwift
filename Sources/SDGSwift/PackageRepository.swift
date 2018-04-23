/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

public struct PackageRepository {

    // MARK: - Initialization

    /// Creates an instance describing an existing package repository.
    public init(at location: URL) {
        self.location = location
    }

    // MARK: - Properties

    /// The location of the repository.
    public let location: URL
}
