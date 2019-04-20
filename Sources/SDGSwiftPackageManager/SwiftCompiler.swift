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

    private static func manifestResourceProvider() throws -> ManifestResourceProvider {
        let destination = try Destination.hostDestination(AbsolutePath(location().deletingLastPathComponent().path))
        return try UserToolchain(destination: destination).manifestResources
        /*return UserManifestResources(
            swiftCompiler: AbsolutePath(try _compilerLocation().path),
            libDir: AbsolutePath(try _packageManagerLibraries().path))*/
    }

    internal static func manifestLoader() throws -> ManifestLoader {
        return ManifestLoader(manifestResources: try manifestResourceProvider())
    }
}
