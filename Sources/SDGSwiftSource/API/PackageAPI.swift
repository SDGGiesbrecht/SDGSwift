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

    // MARK: - Initialization

    /// Creates a package API instance by parsing the specified package’s sources.
    ///
    /// - Throws: Errors inherited from `Syntax.parse(_:)`.
    public init(package: PackageModel.Package) throws {
        _name = package.name.decomposedStringWithCanonicalMapping
        super.init()

        let manifestURL = URL(fileURLWithPath: package.manifest.path.asString)
        let manifest = try Syntax.parse(manifestURL)

        let declaration = manifest.smallestSubnode(containing: "Package(\n    name: \u{22}\(package.name)\u{22}")?.parent
        print(declaration)
        documentation = declaration?.documentation
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
