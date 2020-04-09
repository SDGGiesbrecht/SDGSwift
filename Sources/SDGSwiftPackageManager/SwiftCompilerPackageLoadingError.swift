/*
 SwiftCompilerPackageLoadingError.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(Swift 5.2.1, Web lacks Foundation.)
  import SDGText
  import SDGLocalization

  import SDGSwift

  // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
  #if !(os(Windows) || os(Android))
    import Workspace
  #endif

  extension SwiftCompiler {

    // #workaround(workspace version 0.32.0, SwiftPM won’t compile.)
    #if !(os(Windows) || os(Android))
      /// An error encountered while loading a Swift package.
      public enum PackageLoadingError: PresentableError {

        // MARK: - Cases

        /// Swift could not be located.
        case swiftLocationError(VersionedExternalProcessLocationError<SwiftCompiler>)

        /// The package manager encountered an error.
        case packageManagerError(Swift.Error?, [Diagnostic])

        // MARK: - PresentableError

        public func presentableDescription() -> StrictString {
          switch self {
          case .swiftLocationError(let error):
            return error.presentableDescription()
          case .packageManagerError(let error, let diagnostics):
            var lines: [String] = []
            if let error = error {
              lines.append(error.localizedDescription)
            }
            lines += diagnostics.map({ $0.localizedDescription })
            return StrictString(lines.joined(separator: "\n"))
          }
        }
      }
    #endif
  }
#endif
