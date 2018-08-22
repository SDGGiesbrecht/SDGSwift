/*
 PackageAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftPackageManager

public class PackageAPI : APIElement {

    /// Creates a package API instance by parsing the specified package’s sources.
    ///
    /// - Throws: Errors inherited from `Syntax.parse(_:)`.
    public init(package: PackageModel.Package) throws {
        _name = package.name.decomposedStringWithCanonicalMapping
    }

    // MARK: - Properties

    private let _name: String
    public override var name: String {
        return _name
    }

    public override var declaration: String {
        return "Package(name: \u{22}\(name)\u{22})"
    }

    public override var summary: [String] {
        return [name + " • " + declaration]
    }
}
