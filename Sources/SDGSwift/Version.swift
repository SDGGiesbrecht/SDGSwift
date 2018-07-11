/*
 Version.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2017–2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGControlFlow
import SDGLogic
import SDGCollections

import SDGSwiftLocalizations

/// A semantic version.
public struct Version : Codable, Comparable, Equatable, ExpressibleByStringLiteral, Hashable, TextualPlaygroundDisplay {

    // MARK: - Initialization

    /// Creates a version.
    public init(_ major: Int, _ minor: Int = 0, _ patch: Int = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    // MARK: - Properties

    /// The major version number.
    public var major: Int
    /// The minor version number.
    public var minor: Int
    /// The patch version number.
    public var patch: Int

    // MARK: - Usage

    /// The range of compatible versions.
    ///
    /// i.e. 1.2.3 is compatible with any version where 1.2.3 ≤ x < 2.0.0.
    ///
    /// This property assumes that versions beginning with a zero increment the second number for breaking changes and the third for compatible changes. i.e. 0.1.2 is compatible with any version where 0.1.2 ≤ x < 0.2.0.
    public var compatibleVersions: Range<Version> {
        let nextIncompatible: Version

        if major == 0 {
            nextIncompatible = Version(major, minor + 1)
        } else {
            nextIncompatible = Version(major + 1)
        }

        return self ..< nextIncompatible
    }

    // MARK: - String Representations

    /// Returns the version’s string representation.
    ///
    /// - Parameters:
    ///     - droppingEmptyPatch: Optional. Set to `true` to have the patch number left off if it is zero. (i.e. “1.0” instead of “1.0.0”, but still “1.0.1” regardless.)
    public func string(droppingEmptyPatch: Bool = false) -> String {
        var result = "\(major).\(minor)"
        if ¬droppingEmptyPatch ∨ patch ≠ 0 {
            result += ".\(patch)"
        }
        return result
    }

    /// Creates a version from its string representation.
    public init?(_ string: String) {
        let parsed: [String] = string.components(separatedBy: ".").map { String($0.contents) }
        var sections = parsed[parsed.bounds]

        self = Version(0) // Initialize empty to allow use of property references below.

        func parseNext(into destination: inout Int) -> Bool {
            if let next = sections.popFirst() {
                guard let number = Int(next) else {
                    return false
                }
                destination = number
            } else {
                destination = 0
            }
            return true
        }

        if ¬parseNext(into: &major) {
            return nil
        }

        if ¬parseNext(into: &minor) {
            return nil
        }

        if ¬parseNext(into: &patch) {
            return nil
        }

        if ¬sections.isEmpty {
            return nil
        }
    }

    /// Creates an instance representing the first version in a string.
    public init?(firstIn string: String) {
        let versionPattern = RepetitionPattern(ConditionalPattern({ (scalar: UnicodeScalar) in
            let versionScalars: Set<UnicodeScalar> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
            return scalar ∈ versionScalars
        }), count: 1 ..< Int.max)
        let components = StrictString(string).matches(for: versionPattern).lazy.map({ String(StrictString($0.contents)) })

        for possibleMatch in components {
            if let version = Version(possibleMatch) {
                self = version
                return
            }
        }

        return nil
    }

    // MARK: - Comparable

    // #workaround(SDGCornerstone 0.10.1, Detatched until available again.)
    // @documentation(SDGCornerstone.Comparable.<)
    /// Returns `true` if the preceding value is less than the following value.
    ///
    /// - Parameters:
    ///     - precedingValue: A value.
    ///     - followingValue: Another value.
    public static func < (lhs: Version, rhs: Version) -> Bool {
        return (lhs.major, lhs.minor, lhs.patch) < (rhs.major, rhs.minor, rhs.patch)
    }

    // MARK: - CustomStringConvertible

    // #documentation(SDGCornerstone.CustomStringConvertible.description)
    /// A textual representation of the instance.
    public var description: String {
        return string()
    }

    // MARK: - Equatable

    // #documentation(SDGCornerstone.Equatable.==)
    /// Returns `true` if the two values are equal.
    ///
    /// - Parameters:
    ///     - precedingValue: A value to compare.
    ///     - followingValue: Another value to compare.
    public static func == (lhs: Version, rhs: Version) -> Bool {
        return (lhs.major, lhs.minor, lhs.patch) == (rhs.major, rhs.minor, rhs.patch)
    }

    // MARK: - ExpressibleByStringLiteral

    // #workaround(SDGCornerstone 0.10.1, Detatched until available again.)
    // @documentation(SDGCornerstone.ExpressibleByStringLiteral.init(stringLiteral:))
    /// Creates an instance from a string literal.
    ///
    /// - Parameters:
    ///     - stringLiteral: The string literal.
    public init(stringLiteral: String) {
        guard let result = Version(stringLiteral) else {
            preconditionFailure(UserFacing<StrictString, APILocalization>({ localization in
                switch localization {
                case .englishCanada: // @exempt(from: tests)
                    return StrictString("“\(stringLiteral)” is not a version number.")
                }
            }))
        }
        self = result
    }

    // MARK: - Hashable

    // #workaround(SDGCornerstone 0.10.1, Detatched until available again.)
    // @documentation(SDGCornerstone.Hashable.hashValue)
    /// The hash value.
    public var hashValue: Int {
        return string().hashValue
    }
}
