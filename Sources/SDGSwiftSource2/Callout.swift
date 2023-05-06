/*
 Callout.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGText

import SDGSwiftLocalizations

// #workaround(Can docc handle this?)

/// A documentation callout.
public enum Callout: String, CaseIterable, Sendable {

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

  /// Creates a callout from a callout identifier.
  ///
  /// - Parameters:
  ///   - identifier: The callout identifier.
  public init?(_ identifier: String) {
    if let exists = Callout.lowercasedMapping[identifier.lowercased()] {
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
      case .deutschDeutschland:
        return "Übergabewert"
      }
    case .parameters:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Parameters"
      case .deutschDeutschland:
        return "Übergabewerte"
      }
    case .attention:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Attention"
      case .deutschDeutschland:
        return "Achtung"
      }
    case .author:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Author"
      case .deutschDeutschland:
        return "Verfasser"
      }
    case .authors:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Authors"
      case .deutschDeutschland:
        return "Verfasser"
      }
    case .bug:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Bug"
      case .deutschDeutschland:
        return "Programmfehler"
      }
    case .complexity:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Complexity"
      case .deutschDeutschland:
        return "Komplexität"
      }
    case .copyright:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Copyright"
      case .deutschDeutschland:
        return "Urheberrecht"
      }
    case .date:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Date"
      case .deutschDeutschland:
        return "Datum"
      }
    case .experiment:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Experiment"
      case .deutschDeutschland:
        return "Versuch"
      }
    case .important:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Important"
      case .deutschDeutschland:
        return "Wichtig"
      }
    case .invariant:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Invariant"
      case .deutschDeutschland:
        return "Invariante"
      }
    case .localizationKey:
      switch match {
      case .englishUnitedKingdom:
        return "Localisation Key"
      case .englishUnitedStates, .englishCanada:
        return "Localization Key"
      case .deutschDeutschland:
        return "Lokalisierungsschlüssel"
      }
    case .mutatingVariant:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Mutating Variant"
      case .deutschDeutschland:
        return "Ändernde Nebenform"
      }
    case .nonmutatingVariant:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Non‐mutating Variant"
      case .deutschDeutschland:
        return "Nicht ändernde Nebenform"
      }
    case .note:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Note"
      case .deutschDeutschland:
        return "Hinweis"
      }
    case .postcondition:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Postcondition"
      case .deutschDeutschland:
        return "Nachbedingung"
      }
    case .precondition:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Precondition"
      case .deutschDeutschland:
        return "Vorbedingung"
      }
    case .remark:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Remark"
      case .deutschDeutschland:
        return "Anmerkung"
      }
    case .remarks:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Remarks"
      case .deutschDeutschland:
        return "Anmerkungen"
      }
    case .returns:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Returns"
      case .deutschDeutschland:
        return "Ergibt"
      }
    case .requires:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Requires"
      case .deutschDeutschland:
        return "Setzt voraus"
      }
    case .seeAlso:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "See Also"
      case .deutschDeutschland:
        return "Siehe auch"
      }
    case .since:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Since"
      case .deutschDeutschland:
        return "Seit"
      }
    case .tag:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Tag"
      case .deutschDeutschland:
        return "Etikett"
      }
    case .toDo:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "To Do"
      case .deutschDeutschland:
        return "Aufgabe"
      }
    case .`throws`:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Throws"
      case .deutschDeutschland:
        return "Wirft"
      }
    case .version:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada,
        .deutschDeutschland:
        return "Version"
      }
    case .warning:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Warning"
      case .deutschDeutschland:
        return "Warnung"
      }
    case .keyword:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Keyword"
      case .deutschDeutschland:
        return "Schlagwort"
      }
    case .recommended:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Recommended"
      case .deutschDeutschland:
        return "Empfohlen"
      }
    case .recommendedOver:
      switch match {
      case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
        return "Recommended over"
      case .deutschDeutschland:
        return "Empfohlen über"
      }
    }
  }
}
