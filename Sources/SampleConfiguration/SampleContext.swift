/*
 SampleContext.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGSwiftConfiguration

/// A sample configuration context.
public struct SampleContext: Context {

  // MARK: - Static Properties

  /// The context received from the configuration loader.
  public static var context: SampleContext? = SampleContext.accept()

  // MARK: - Initialization

  /// Creates the context.
  ///
  /// - Parameters:
  ///     - information: Context information to be supplied.
  public init(information: String) {
    self.information = information
  }

  // MARK: - Properties

  /// Sample context information.
  public var information: String
}
