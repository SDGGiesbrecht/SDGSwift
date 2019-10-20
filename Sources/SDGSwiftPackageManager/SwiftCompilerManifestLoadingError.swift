/*
 SwiftCompilerManifestLoadingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGSwift

extension SwiftCompiler {

    /// An error encountered while loading a Swift package.
    public enum PackageLoadingError : PresentableError {

        // MARK: - Cases

        /// Swift could not be located.
        case swiftLocationError(LocationError)

        /// The package manager encountered an error.
        case packageManagerError(Swift.Error)

        // MARK: - PresentableError

        // #workaround(workspace version 0.23.1, Avoids parser crash.)
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .swiftLocationError(let error):
                return error.presentableDescription()
            case .packageManagerError(let error):
                #warning("Investigate diagnostics.")
                return StrictString(error.localizedDescription)
            }
        }
    }
}
