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

internal enum Callout: String, CaseIterable, Sendable {

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

  internal init?(_ identifier: String) {
    if let exists = Callout.lowercasedMapping[identifier.lowercased()] {
      self = exists
    } else {
      return nil
    }
  }
}
