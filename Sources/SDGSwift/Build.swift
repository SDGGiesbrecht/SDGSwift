/*
 Build.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLocalization
import SDGSwiftLocalizations

/// A package build.
public enum Build : Equatable, TextualPlaygroundDisplay {

    // MARK: - Cases

    /// A versioned release.
    case version(Version)

    /// The current state of development.
    case development

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        switch self {
        case .version(let version):
            return version.string()
        case .development:
            return String(UserFacing<StrictString, InterfaceLocalization>({ localization in
                switch localization {
                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                    return "development"
                }
            }).resolved())
        }
    }
}
