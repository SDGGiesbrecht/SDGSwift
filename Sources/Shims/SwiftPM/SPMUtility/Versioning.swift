/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import clibc

/// A Swift version number.
///
/// Note that these are *NOT* semantically versioned numbers.
public struct SwiftVersion {
    /// The version number.
    public var version: (major: Int, minor: Int, patch: Int)

    /// Whether or not this is a development version.
    public var isDevelopment: Bool

    /// Build information, as an unstructured string.
    public var buildIdentifier: String?

    /// The major component of the version number.
    public var major: Int { return version.major }
    /// The minor component of the version number.
    public var minor: Int { return version.minor }
    /// The patch component of the version number.
    public var patch: Int { return version.patch }

    /// The version as a readable string.
    public var displayString: String {
        var result = "\(major).\(minor).\(patch)"
        if isDevelopment {
            result += "-dev"
        }
        if let buildIdentifier = self.buildIdentifier {
            result += " (" + buildIdentifier + ")"
        }
        return result
    }

    /// The complete product version display string (including the name).
    public var completeDisplayString: String {
        var vendorPrefix = String(cString: SPM_VendorNameString())
        if !vendorPrefix.isEmpty {
            vendorPrefix += " "
        }
        return vendorPrefix + "Swift Package Manager - Swift " + displayString
    }

    /// The list of version specific identifiers to search when attempting to
    /// load version specific package or version information, in order of
    /// preference.
    public var versionSpecificKeys: [String] {
        return [
            "@swift-\(major).\(minor).\(patch)",
            "@swift-\(major).\(minor)",
            "@swift-\(major)",
        ]
    }

}

private func getBuildIdentifier() -> String? {
    let buildIdentifier = String(cString: SPM_BuildIdentifierString())
    return buildIdentifier.isEmpty ? nil : buildIdentifier
}

/// Version support for the package manager.
public struct Versioning {

    /// The current version of the package manager.
    public static let currentVersion = SwiftVersion(
        version: (5, 0, 0),
        isDevelopment: false,
        buildIdentifier: getBuildIdentifier())

    /// The list of version specific "keys" to search when attempting to load
    /// version specific package or version information, in order of preference.
    public static let currentVersionSpecificKeys = currentVersion.versionSpecificKeys
}
