/*
 XcodeCoverageReportingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

import SDGSwift
import SDGSwiftPackageManager

extension Xcode {

    /// An error encountered while checking test coverage.
    public enum CoverageReportingError : PresentableError {

        // MARK: - Cases

        /// The host destination could not be determined.
        case hostDestinationError(SwiftCompiler.HostDestinationError)

        /// The build directory could not be located.
        case buildDirectoryError(BuildDirectoryError)

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
            switch self {
            case .hostDestinationError(let error):
                return error.presentableDescription()
            case .buildDirectoryError(let error):
                return error.presentableDescription()
            }
        }
    }
}
