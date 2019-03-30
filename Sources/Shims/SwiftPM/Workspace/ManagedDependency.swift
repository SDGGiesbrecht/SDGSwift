/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
 */

import Basic
import PackageGraph
import PackageModel
import SourceControl
import SPMUtility

/// An individual managed dependency.
///
/// Each dependency will have a checkout containing the sources at a
/// particular revision, and may have an associated version.
public final class ManagedDependency: JSONMappable, JSONSerializable, CustomStringConvertible {

    /// Represents the state of the managed dependency.
    public enum State: Equatable, CustomStringConvertible {

        /// The dependency is a managed checkout.
        case checkout(CheckoutState)

        /// The dependency is in edited state.
        ///
        /// If the path is non-nil, the dependency is managed by a user and is
        /// located at the path. In other words, this dependency is being used
        /// for top of the tree style development.
        case edited(AbsolutePath?)

        // The dependency is a local package.
        case local

        /// Returns true if state is checkout.
        var isCheckout: Bool {
            if case .checkout = self { return true }
            return false
        }

        public var description: String {
            switch self {
            case .checkout(let checkout):
                return "\(checkout)"
            case .edited:
                return "edited"
            case .local:
                return "local"
            }
        }
    }

    /// The package reference.
    public let packageRef: PackageReference

    /// The state of the managed dependency.
    public let state: State

    /// The checked out path of the dependency on disk, relative to the workspace checkouts path.
    public let subpath: RelativePath

    /// A dependency which in editable state is based on a dependency from
    /// which it edited from.
    ///
    /// This information is useful so it can be restored when users
    /// unedit a package.
    var basedOn: ManagedDependency?

    init(
        packageRef: PackageReference,
        subpath: RelativePath,
        checkoutState: CheckoutState
    ) {
        self.packageRef = packageRef
        self.state = .checkout(checkoutState)
        self.basedOn = nil
        self.subpath = subpath
    }

    /// Create a dependency present locally on the filesystem.
    static func local(
        packageRef: PackageReference
    ) -> ManagedDependency {
        return ManagedDependency(
            packageRef: packageRef,
            state: .local,
            // FIXME: This is just a fake entry, we should fix it.
            subpath: RelativePath(packageRef.identity),
            basedOn: nil
        )
    }

    private init(
        packageRef: PackageReference,
        state: State,
        subpath: RelativePath,
        basedOn: ManagedDependency?
    ) {
        self.packageRef = packageRef
        self.subpath = subpath
        self.basedOn = basedOn
        self.state = state
    }

    private init(
        basedOn dependency: ManagedDependency,
        subpath: RelativePath,
        unmanagedPath: AbsolutePath?
    ) {
        assert(dependency.state.isCheckout)
        self.basedOn = dependency
        self.packageRef = dependency.packageRef
        self.subpath = subpath
        self.state = .edited(unmanagedPath)
    }

    /// Create an editable managed dependency based on a dependency which
    /// was *not* in edit state.
    ///
    /// - Parameters:
    ///     - subpath: The subpath inside the editables directory.
    ///     - unmanagedPath: A custom absolute path instead of the subpath.
    func editedDependency(subpath: RelativePath, unmanagedPath: AbsolutePath?) -> ManagedDependency {
        return ManagedDependency(basedOn: self, subpath: subpath, unmanagedPath: unmanagedPath)
    }

    public init(json: JSON) throws {
        self.packageRef = try json.get("packageRef")
        self.subpath = try RelativePath(json.get("subpath"))
        self.basedOn = json.get("basedOn")
        self.state = try json.get("state")
    }

    public func toJSON() -> JSON {
        return .init([
            "packageRef": packageRef.toJSON(),
            "subpath": subpath,
            "basedOn": basedOn.toJSON(),
            "state": state,
        ])
    }

    public var description: String {
        return "<ManagedDependency: \(packageRef.name ?? packageRef.identity) \(state)>"
    }
}

extension ManagedDependency.State: JSONMappable, JSONSerializable {
    public func toJSON() -> JSON {
        switch self {
        case .checkout(let checkoutState):
            return .init([
                "name": "checkout",
                "checkoutState": checkoutState,
            ])
        case .edited(let path):
            return .init([
                "name": "edited",
                "path": path.toJSON(),
            ])
        case .local:
            return .init([
                "name": "local",
            ])
        }
    }

    public init(json: JSON) throws {
        let name: String = try json.get("name")
        switch name {
        case "checkout":
            self = try .checkout(json.get("checkoutState"))
        case "edited":
            let path: String? = json.get("path")
            self = .edited(path.map({AbsolutePath($0)}))
        case "local":
            self = .local
        default:
            throw JSON.MapError.custom(key: nil, message: "Invalid state \(name)")
        }
    }
}

/// Represents a collection of managed dependency which are persisted on disk.
public final class ManagedDependencies: SimplePersistanceProtocol {

    enum Error: Swift.Error, CustomStringConvertible {
        case dependencyNotFound(name: String)

        var description: String {
            switch self {
            case .dependencyNotFound(let name):
                return "Could not find dependency '\(name)'"
            }
        }
    }

    /// The schema version of the resolved file.
    ///
    /// * 2: Package identity.
    /// * 1: Initial version.
    static let schemaVersion: Int = 2

    /// The current state of managed dependencies.
    ///
    /// Key -> package URL.
    private var dependencyMap: [String: ManagedDependency]

    /// Path to the state file.
    let statePath: AbsolutePath

    /// persistence helper
    let persistence: SimplePersistence

    init(dataPath: AbsolutePath, fileSystem: FileSystem) {
        let statePath = dataPath.appending(component: "dependencies-state.json")

        self.dependencyMap = [:]
        self.statePath = statePath
        self.persistence = SimplePersistence(
            fileSystem: fileSystem,
            schemaVersion: ManagedDependencies.schemaVersion,
            statePath: statePath)

        // Load the state from disk, if possible.
        //
        // If the disk operation here fails, we ignore the error here.
        // This means if managed dependencies data is corrupted or out of date,
        // clients will not see the old data and managed dependencies will be
        // reset.  However there could be other errors, like permission issues,
        // these errors will also be ignored but will surface when clients try
        // to save the state.
        do {
            try self.persistence.restoreState(self)
        } catch {
            // FIXME: We should emit a warning here using the diagnostic engine.
            print("\(error)")
        }
    }

    public subscript(forURL url: String) -> ManagedDependency? {
        get {
            return dependencyMap[url]
        }
        set {
            dependencyMap[url] = newValue
        }
    }

    /// Returns the dependency given a name or identity.
    func dependency(forNameOrIdentity nameOrIdentity: String) throws -> ManagedDependency {
        for value in values {
            if value.packageRef.name == nameOrIdentity {
                return value
            } else if value.packageRef.identity == nameOrIdentity.lowercased() {
                return value
            }
        }
        throw Error.dependencyNotFound(name: nameOrIdentity)
    }

    func dependency(forIdentity identity: String) -> ManagedDependency? {
        return values.first(where: { $0.packageRef.identity == identity })
    }

    func reset() throws {
        dependencyMap = [:]
        try saveState()
    }

    func saveState() throws {
        try self.persistence.saveState(self)
    }

     /// Returns true if the state file exists on the filesystem.
     public func stateFileExists() -> Bool {
         return persistence.stateFileExists()
     }

    public var values: AnySequence<ManagedDependency> {
        return AnySequence<ManagedDependency>(dependencyMap.values)
    }

    public func restore(from json: JSON) throws {
        self.dependencyMap = try Dictionary(items:
            json.get("dependencies").map({ ($0.packageRef.path, $0) })
        )
    }

    public func toJSON() -> JSON {
        return JSON([
            "dependencies": values.toJSON(),
        ])
    }
}
