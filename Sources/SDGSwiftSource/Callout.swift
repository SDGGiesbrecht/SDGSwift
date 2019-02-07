/*
 Callout.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

/// A documentation callout.
public enum Callout : String, CaseIterable {

    // MARK: - Cases

    // From https://github.com/apple/swift/blob/master/include/swift/Markup/SimpleFields.def

    /// “Parameter”.
    case parameter = "Parameter"
    /// “Parameters”.
    case parameters = "Parameters"

    /// “Attention.”.
    case attention = "Attention"
    /// “Author”.
    case author = "Author"
    /// “Authors”.
    case authors = "Authors"
    /// “Bug”.
    case bug = "Bug"
    /// “Complexity”.
    case complexity = "Complexity"
    /// “Copyright”.
    case copyright = "Copyright"
    /// “Date”.
    case date = "Date"
    /// “Experiment”.
    case experiment = "Experiment"
    /// “Important”.
    case important = "Important"
    /// “Invariant”.
    case invariant = "Invariant"
    /// “LocalizationKey”.
    case localizationKey = "LocalizationKey"
    /// “MutatingVariant”.
    case mutatingVariant = "MutatingVariant"
    /// “NonmutatingVariant”.
    case nonmutatingVariant = "NonmutatingVariant"
    /// “Note”.
    case note = "Note"
    /// “Postcondition”.
    case postcondition = "Postcondition"
    /// “Precondition”.
    case precondition = "Precondition"
    /// “Remark”.
    case remark = "Remark"
    /// “Remarks”.
    case remarks = "Remarks"
    /// “Returns”.
    case returns = "Returns"
    /// “Requires”.
    case requires = "Requires"
    /// “SeeAlso”.
    case seeAlso = "SeeAlso"
    /// “Since”.
    case since = "Since"
    /// “Tag”.
    case tag = "Tag"
    /// “ToDo”.
    case toDo = "ToDo"
    /// “Throws”.
    case `throws` = "Throws"
    /// “Version”.
    case version = "Version"
    /// “Warning”.
    case warning = "Warning"
    /// “Keyword”.
    case keyword = "Keyword"
    /// “Recommended”.
    case recommended = "Recommended"
    /// “RecommendedOver”.
    case recommendedOver = "RecommendedOver"

    // MARK: - Type Properties

    private static let lowercasedMapping: [String: Callout] = {
        var result: [String: Callout] = [:]
        for `case` in allCases {
            result[`case`.rawValue.lowercased()] = `case`
        }
        return result
    }()

    // MARK: - Initialization

    internal init?(_ string: String) {
        if let exists = Callout.lowercasedMapping[string.lowercased()] {
            self = exists
        } else {
            return nil
        }
    }

    // MARK: - Properties

    /// Returns a localized heading for the generated callout.
    ///
    /// - Parameters:
    ///     - localization: The code of the desired localization.
    public func localizedText(_ localization: String) -> StrictString {
        guard let match = InterfaceLocalization(reasonableMatchFor: localization) else {
            return StrictString(rawValue)
        }

        switch self {
        case .parameter:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Parameter"
            }
        case .parameters:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Parameters"
            }
        case .attention:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Attention"
            }
        case .author:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Author"
            }
        case .authors:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Authors"
            }
        case .bug:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Bug"
            }
        case .complexity:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Complexity"
            }
        case .copyright:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Copyright"
            }
        case .date:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Date"
            }
        case .experiment:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Experiment"
            }
        case .important:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Important"
            }
        case .invariant:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Invariant"
            }
        case .localizationKey:
            switch match {
            case .englishUnitedKingdom:
                return "Localisation Key"
            case .englishUnitedStates, .englishCanada:
                return "Localization Key"
            }
        case .mutatingVariant:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Mutating Variant"
            }
        case .nonmutatingVariant:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Non‐mutating Variant"
            }
        case .note:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Note"
            }
        case .postcondition:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Postcondition"
            }
        case .precondition:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Precondition"
            }
        case .remark:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Remark"
            }
        case .remarks:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Remarks"
            }
        case .returns:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Returns"
            }
        case .requires:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Requires"
            }
        case .seeAlso:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "See Also"
            }
        case .since:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Since"
            }
        case .tag:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Tag"
            }
        case .toDo:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "To Do"
            }
        case .`throws`:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Throws"
            }
        case .version:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Version"
            }
        case .warning:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Warning"
            }
        case .keyword:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Keyword"
            }
        case .recommended:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Recommended"
            }
        case .recommendedOver:
            switch match {
            case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                return "Recommended over"
            }
        }
    }
}
