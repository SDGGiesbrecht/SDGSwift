/*
 SwiftCompilerHostDestinationError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwift

extension SwiftCompiler {

    /// An error encountered while determining the host destination.
    public enum HostDestinationError : PresentableError {

        // MARK: - Cases

        /// An error encountered while locating Swift.
        case swiftLocationError(LocationError)

        /// The package manager encountered an error.
        case packageManagerError(Swift.Error)

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .swiftLocationError(let error):
                return error.presentableDescription()
            case .packageManagerError(let error):
                return StrictString(error.localizedDescription)
            }
        }
    }
}
