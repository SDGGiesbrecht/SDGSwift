/*
 Identifier.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGCollections

/// An identifier.
public class Identifier : AtomicSyntaxElement {

    // MARK: - Static Properties

    /// The characters an identifier is allowed to start with.
    public static let identifierStarterCharacters: CharacterSet = {
        // From https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID412
        var result = CharacterSet(charactersIn: "A" ... "Z")

        result.insert(charactersIn: "a" ... "z")

        result.insert(charactersIn: "_")
        result.insert(charactersIn: "\u{A8}\u{AA}\u{AD}\u{AF}")
        result.insert(charactersIn: Unicode.Scalar(0xB2) ... Unicode.Scalar(0xB5))
        result.insert(charactersIn: Unicode.Scalar(0xB7) ... Unicode.Scalar(0xBA))

        result.insert(charactersIn: Unicode.Scalar(0xBC) ... Unicode.Scalar(0xBE))
        result.insert(charactersIn: Unicode.Scalar(0xC0) ... Unicode.Scalar(0xD6))
        result.insert(charactersIn: Unicode.Scalar(0xD8) ... Unicode.Scalar(0xF6))
        result.insert(charactersIn: Unicode.Scalar(0xF8) ... Unicode.Scalar(0xFF))

        result.insert(charactersIn: Unicode.Scalar(0x100)! ... Unicode.Scalar(0x2FF)!)
        result.insert(charactersIn: Unicode.Scalar(0x370)! ... Unicode.Scalar(0x167F)!)
        result.insert(charactersIn: Unicode.Scalar(0x1681)! ... Unicode.Scalar(0x180D)!)
        result.insert(charactersIn: Unicode.Scalar(0x180F)! ... Unicode.Scalar(0x1DBF)!)

        result.insert(charactersIn: Unicode.Scalar(0x1E00)! ... Unicode.Scalar(0x1FFF)!)

        result.insert(charactersIn: Unicode.Scalar(0x200B)! ... Unicode.Scalar(0x200D)!)
        result.insert(charactersIn: Unicode.Scalar(0x202A)! ... Unicode.Scalar(0x202E)!)
        result.insert(charactersIn: Unicode.Scalar(0x203F)! ... Unicode.Scalar(0x2040)!)
        result.insert(charactersIn: "\u{2054}")
        result.insert(charactersIn: Unicode.Scalar(0x2060)! ... Unicode.Scalar(0x206F)!)

        result.insert(charactersIn: Unicode.Scalar(0x2070)! ... Unicode.Scalar(0x20CF)!)
        result.insert(charactersIn: Unicode.Scalar(0x2100)! ... Unicode.Scalar(0x218F)!)
        result.insert(charactersIn: Unicode.Scalar(0x2460)! ... Unicode.Scalar(0x24FF)!)
        result.insert(charactersIn: Unicode.Scalar(0x2776)! ... Unicode.Scalar(0x2793)!)

        result.insert(charactersIn: Unicode.Scalar(0x2C00)! ... Unicode.Scalar(0x2DFF)!)
        result.insert(charactersIn: Unicode.Scalar(0x2E80)! ... Unicode.Scalar(0x2FFF)!)

        result.insert(charactersIn: Unicode.Scalar(0x3004)! ... Unicode.Scalar(0x3007)!)
        result.insert(charactersIn: Unicode.Scalar(0x3021)! ... Unicode.Scalar(0x302F)!)
        result.insert(charactersIn: Unicode.Scalar(0x3031)! ... Unicode.Scalar(0x303F)!)
        result.insert(charactersIn: Unicode.Scalar(0x3040)! ... Unicode.Scalar(0xD7FF)!)

        result.insert(charactersIn: Unicode.Scalar(0xF900)! ... Unicode.Scalar(0xFD3D)!)
        result.insert(charactersIn: Unicode.Scalar(0xFD40)! ... Unicode.Scalar(0xFDCF)!)
        result.insert(charactersIn: Unicode.Scalar(0xFDF0)! ... Unicode.Scalar(0xFE1F)!)
        result.insert(charactersIn: Unicode.Scalar(0xFE30)! ... Unicode.Scalar(0xFE44)!)

        result.insert(charactersIn: Unicode.Scalar(0xFE47)! ... Unicode.Scalar(0xFFFD)!)

        result.insert(charactersIn: Unicode.Scalar(0x10000)! ... Unicode.Scalar(0x1FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0x20000)! ... Unicode.Scalar(0x2FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0x30000)! ... Unicode.Scalar(0x3FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0x40000)! ... Unicode.Scalar(0x4FFFD)!)

        result.insert(charactersIn: Unicode.Scalar(0x50000)! ... Unicode.Scalar(0x5FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0x60000)! ... Unicode.Scalar(0x6FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0x70000)! ... Unicode.Scalar(0x7FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0x80000)! ... Unicode.Scalar(0x8FFFD)!)

        result.insert(charactersIn: Unicode.Scalar(0x90000)! ... Unicode.Scalar(0x9FFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0xA0000)! ... Unicode.Scalar(0xAFFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0xB0000)! ... Unicode.Scalar(0xBFFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0xC0000)! ... Unicode.Scalar(0xCFFFD)!)

        result.insert(charactersIn: Unicode.Scalar(0xD0000)! ... Unicode.Scalar(0xDFFFD)!)
        result.insert(charactersIn: Unicode.Scalar(0xE0000)! ... Unicode.Scalar(0xEFFFD)!)

        return result
    }()

    /// The characters an identifier is allowed to contain.
    ///
    /// Some of these characters are not allowed at the start. See `identifierStarterCharacters`.
    private static let identifierCharacters: CharacterSet = {
        // From https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID412
        var result = CharacterSet(charactersIn: "0" ... "9")

        result.insert(charactersIn: Unicode.Scalar(0x300)! ... Unicode.Scalar(0x36F)!)
        result.insert(charactersIn: Unicode.Scalar(0x1DC0)! ... Unicode.Scalar(0x1DFF)!)
        result.insert(charactersIn: Unicode.Scalar(0x20D0)! ... Unicode.Scalar(0x20FF)!)
        result.insert(charactersIn: Unicode.Scalar(0xFE20)! ... Unicode.Scalar(0xFE2F)!)

        result.formUnion(identifierStarterCharacters)

        return result
    }()

    /// The characters an operator is allowed to start with.
    ///
    /// The dot (U+002E) is unusual. It can start an operator, but it cannot be one in isolation.
    public static let operatorStarterCharactersIncludingDot: CharacterSet = {
        // From https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418
        var result: CharacterSet = ["/", "=", "\u{2D}", "+", "!", "*", "%", "<", ">", "&", "|", "^", "~", "?"]

        result.insert(charactersIn: Unicode.Scalar(0xA1) ... Unicode.Scalar(0xA7))

        result.insert(Unicode.Scalar(0xA9))
        result.insert(Unicode.Scalar(0xAB))

        result.insert(Unicode.Scalar(0xAC))
        result.insert(Unicode.Scalar(0xAE))

        result.insert(charactersIn: Unicode.Scalar(0xB0) ... Unicode.Scalar(0xB1))
        result.insert(Unicode.Scalar(0xB6))
        result.insert(Unicode.Scalar(0xBB))
        result.insert(Unicode.Scalar(0xBF))
        result.insert(Unicode.Scalar(0xD7))
        result.insert(Unicode.Scalar(0xF7))

        result.insert(charactersIn: Unicode.Scalar(0x2016)! ... Unicode.Scalar(0x2017)!)
        result.insert(charactersIn: Unicode.Scalar(0x2020)! ... Unicode.Scalar(0x2027)!)

        result.insert(charactersIn: Unicode.Scalar(0x2030)! ... Unicode.Scalar(0x203E)!)

        result.insert(charactersIn: Unicode.Scalar(0x2041)! ... Unicode.Scalar(0x2053)!)

        result.insert(charactersIn: Unicode.Scalar(0x2055)! ... Unicode.Scalar(0x205E)!)

        result.insert(charactersIn: Unicode.Scalar(0x2190)! ... Unicode.Scalar(0x23FF)!)

        result.insert(charactersIn: Unicode.Scalar(0x2500)! ... Unicode.Scalar(0x2775)!)

        result.insert(charactersIn: Unicode.Scalar(0x2794)! ... Unicode.Scalar(0x2BFF)!)

        result.insert(charactersIn: Unicode.Scalar(0x2E00)! ... Unicode.Scalar(0x2E7F)!)

        result.insert(charactersIn: Unicode.Scalar(0x3001)! ... Unicode.Scalar(0x3003)!)

        result.insert(charactersIn: Unicode.Scalar(0x3008)! ... Unicode.Scalar(0x3030)!)

        // The dot cannot be an operator on its own.
        result.insert(".")

        return result
    }()

    /// The characters an operator is allowed to contain.
    ///
    /// The dot (U+002E) is unusual. It can be part of an operator, but it cannot be one in isolation.
    private static let operatorCharactersIncludingDot: CharacterSet = {
        // From https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID412

        var result: CharacterSet = []

        result.insert(charactersIn: Unicode.Scalar(0x300)! ... Unicode.Scalar(0x36F)!)
        result.insert(charactersIn: Unicode.Scalar(0x1DC0)! ... Unicode.Scalar(0x1DFF)!)
        result.insert(charactersIn: Unicode.Scalar(0x20D0)! ... Unicode.Scalar(0x20FF)!)
        result.insert(charactersIn: Unicode.Scalar(0xFE00)! ... Unicode.Scalar(0xFE0F)!)
        result.insert(charactersIn: Unicode.Scalar(0xFE20)! ... Unicode.Scalar(0xFE2F)!)
        result.insert(charactersIn: Unicode.Scalar(0xE0100)! ... Unicode.Scalar(0xE01EF)!)

        result.formUnion(operatorStarterCharactersIncludingDot)

        return result
    }()

    // MARK: - Initialization

    internal init(range: Range<String.ScalarView.Index>, isDefinition: Bool) {
        self.isDefinition = isDefinition
        super.init(range: range)
    }

    // MARK: - Properties

    public private(set) var isDefinition: Bool

    // [_Inherit Documentation: SyntaxElement.textFreedom_]
    /// How much freedom the user has in choosing the text of the element.
    public override var textFreedom: TextFreedom {
        return isDefinition ? .arbitrary : .aliasable
    }
}
