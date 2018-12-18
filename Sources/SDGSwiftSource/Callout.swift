/*
 Callout.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftLocalizations

public enum Callout : String, CaseIterable {

    // MARK: - Cases

    // From https://github.com/apple/swift/blob/master/include/swift/Markup/SimpleFields.def

    case parameter = "Parameter"
    case parameters = "Parameters"

    case attention = "Attention"
    case author = "Author"
    case authors = "Authors"
    case bug = "Bug"
    case complexity = "Complexity"
    case copyright = "Copyright"
    case date = "Date"
    case experiment = "Experiment"
    case important = "Important"
    case invariant = "Invariant"
    case localizationKey = "LocalizationKey"
    case mutatingVariant = "MutatingVariant"
    case nonmutatingVariant = "NonmutatingVariant"
    case note = "Note"
    case postcondition = "Postcondition"
    case precondition = "Precondition"
    case remark = "Remark"
    case remarks = "Remarks"
    case returns = "Returns"
    case requires = "Requires"
    case seeAlso = "SeeAlso"
    case since = "Since"
    case tag = "Tag"
    case toDo = "ToDo"
    case `throws` = "Throws"
    case version = "Version"
    case warning = "Warning"
    case keyword = "Keyword"
    case recommended = "Recommended"
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
