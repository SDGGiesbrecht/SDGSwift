/*
 WorkspaceDelegate.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Basic
import PackageGraph
import Workspace

extension WorkspaceDelegate {
    func packageGraphWillLoad(currentGraph: PackageGraph, dependencies: AnySequence<ManagedDependency>, missingURLs: Set<String>) {}
    func fetchingWillBegin(repository: String) {}
    func fetchingDidFinish(repository: String, diagnostic: Diagnostic?) {}
    func cloning(repository: String) {}
    func removing(repository: String) {}
    func managedDependenciesDidUpdate(_ dependencies: AnySequence<ManagedDependency>) {}
}
