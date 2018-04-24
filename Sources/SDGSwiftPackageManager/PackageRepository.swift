/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Basic
import Workspace

extension PackageRepository {

    /// Creates a pack
    public init(initializingAt location: URL, type: InitPackage.PackageType) throws {
        self.init(at: location)
        let initializer = try InitPackage(destinationPath: AbsolutePath(location.path), packageType: type)
        try initializer.writePackageStructure()
    }
}
