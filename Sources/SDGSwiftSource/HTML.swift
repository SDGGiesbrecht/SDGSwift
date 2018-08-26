/*
 HTML.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

internal enum HTML {
    internal static func escape(_ string: String) -> String {
        return string
            .replacingMatches(for: "&", with: "&#x0026;")
            .replacingMatches(for: "<", with: "&#x003C;")
            .replacingMatches(for: "\u{2066}", with: "<bdi dir=\u{22}ltr\u{22}>")
            .replacingMatches(for: "\u{2067}", with: "<bdi dir=\u{22}rtl\u{22}>")
            .replacingMatches(for: "\u{2068}", with: "<bdi dir=\u{22}auto\u{22}>")
            .replacingMatches(for: "\u{2069}", with: "</bdi>")
    }
}
