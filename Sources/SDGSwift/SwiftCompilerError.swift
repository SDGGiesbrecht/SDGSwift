/*
 SwiftCompilerError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGText
import SDGLocalization
import SDGExternalProcess

import SDGSwiftLocalizations

extension SwiftCompiler {

    /// An error encountered while using Swift.
    public enum Error : PresentableError {

        /// Swift could not be located.
        case locationError(LocationError)

        /// Swift encountered an error during its execution.
        case executionError(ExternalProcess.Error)

        // MARK: - PresentableError

        // #workaround(workspace version 0.23.1, Avoids parser crash.)
        /// Returns a localized description of the error.
        public func presentableDescription() -> StrictString {
            switch self {
            case .locationError(let error):
                return error.presentableDescription()
            case .executionError(let error):
                return error.presentableDescription()
            }
        }
    }
}
