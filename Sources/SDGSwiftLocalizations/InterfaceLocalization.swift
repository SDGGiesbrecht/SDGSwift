/*
 InterfaceLocalization.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

public enum InterfaceLocalization : String, InputLocalization {

    // MARK: - Cases

    case englishUnitedKingdom = "en\u{2D}GB"
    case englishUnitedStates = "en\u{2D}US"
    case englishCanada = "en\u{2D}CA"

    public static let cases: [InterfaceLocalization] = [

        .englishUnitedKingdom,
        .englishUnitedStates,
        .englishCanada
    ]

    // MARK: - Localization

    public static let fallbackLocalization: InterfaceLocalization = .englishCanada
}
