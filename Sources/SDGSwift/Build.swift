/*
 Build.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A package build.
public enum Build : Equatable {

    // MARK: - Cases

    /// A versioned release.
    case version(Version)

    /// The current state of development.
    case development

    // MARK: - Equatable

    // [_Inherit Documentation: SDGCornerstone.Equatable.==_]
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (lhs: Build, rhs: Build) -> Bool {
        switch lhs {
        case .development:
            switch rhs {
            case .development:
                return true
            case .version:
                return false
            }
        case .version(let lhsVersion):
            switch rhs {
            case .development:
                return false
            case .version(let rhsVersion):
                return lhsVersion == rhsVersion
            }
        }
    }
}
