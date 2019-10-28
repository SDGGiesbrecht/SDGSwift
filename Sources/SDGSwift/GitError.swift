/*
 GitError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGText
import SDGLocalization
import SDGExternalProcess

import SDGSwiftLocalizations

extension Git {

    /// An error encountered while using Git.
    public enum Error : PresentableError {

        /// Git could not be located.
        case locationError(LocationError)

        /// Git encountered an error during its execution.
        case executionError(ExternalProcess.Error)

        // MARK: - PresentableError

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
