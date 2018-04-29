/*
 SwiftCompilerManifestResources.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwift

import Basic
import PackageLoading

extension SwiftCompiler {

    internal struct ManifestResources : ManifestResourceProvider {

        // MARK: - Initialization

        internal init(swiftCompiler: URL, librariesDirectory: URL) {
            self.swiftCompiler = AbsolutePath(swiftCompiler.path)
            self.libDir = AbsolutePath(librariesDirectory.path)
        }

        // MARK: - ManifestResourceProvider

        public let swiftCompiler: AbsolutePath
        public let libDir: AbsolutePath
    }
}
