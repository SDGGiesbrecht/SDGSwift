/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift

import PackageLoading
import Workspace

extension SwiftCompiler {

    // MARK: - Properties

    private static func manifestResources() throws -> ManifestResources {
        return ManifestResources(
            swiftCompiler: try _compilerLocation(),
            librariesDirectory: try _packageManagerLibraries())
    }

    internal static func manifestLoader() throws -> ManifestLoader {
        return ManifestLoader(resources: try manifestResources())
    }

    internal static func workspaceDelegate() -> WorkspaceDelegate {
        return DefaultWorkspaceDelegate()
    }
}
