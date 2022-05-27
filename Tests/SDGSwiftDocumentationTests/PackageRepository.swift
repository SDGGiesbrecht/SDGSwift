/*
 PackageRepository.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGSwift
import SDGSwiftSource

import SymbolKit
import SwiftSyntax

#if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
  import PackageModel
#endif

extension PackageRepository {

  #if !PLATFORM_NOT_SUPPORTED_BY_SWIFT_PM
    func api() throws -> PackageAPI {
      let package = try self.package().get()
      let documentation = try PackageAPI.documentation(for: package)
      let declaration = FunctionCallExprSyntax._normalizedPackageDeclaration(
        name: package.manifest.displayName
      )
      return PackageAPI(_documentation: documentation, declaration: declaration)
    }
  #endif
}
