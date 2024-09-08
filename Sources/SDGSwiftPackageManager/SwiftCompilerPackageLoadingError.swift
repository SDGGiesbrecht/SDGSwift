/*
 SwiftCompilerPackageLoadingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText
import SDGLocalization

import SDGSwift

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import Workspace
#endif

extension SwiftCompiler {

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    /// An error encountered while loading a Swift package.
    public enum PackageLoadingError: PresentableError {

      // MARK: - Cases

      /// The package manager encountered an error.
      case packageManagerError(Swift.Error?)

      // MARK: - PresentableError

      public func presentableDescription() -> StrictString {
        switch self {
        case .packageManagerError(let error):
          var lines: [String] = []
          if let error = error {
            lines.append(error.localizedDescription)
          }
          return StrictString(lines.joined(separator: "\n"))
        }
      }
    }
  #endif
}
