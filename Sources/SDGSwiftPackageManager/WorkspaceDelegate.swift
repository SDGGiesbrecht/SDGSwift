
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
