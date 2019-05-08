/*
 PackageStructureBuildError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

extension Package {

    /// An error encountered while building a Swift package.
    public enum BuildError : PresentableError {

        /// Foundation encountered an error.
        case foundationError(Swift.Error)

        /// Swift encountered an error.
        case swiftError(Git.Error)

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .foundationError(let error):
                return StrictString(error.localizedDescription)
            case .swiftError(let error):
                return error.presentableDescription()
            }
        }
    }
}
