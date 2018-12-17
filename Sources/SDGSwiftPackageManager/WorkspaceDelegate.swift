/*
 WorkspaceDelegate.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Basic
import PackageGraph
import Workspace

extension WorkspaceDelegate {
    internal func packageGraphWillLoad(currentGraph: PackageGraph, dependencies: AnySequence<ManagedDependency>, missingURLs: Set<String>) {} // @exempt(from: tests)
    internal func fetchingWillBegin(repository: String) {}
    internal func fetchingDidFinish(repository: String, diagnostic: Diagnostic?) {}
    internal func cloning(repository: String) {}
    internal func removing(repository: String) {}
    internal func managedDependenciesDidUpdate(_ dependencies: AnySequence<ManagedDependency>) {}
}
