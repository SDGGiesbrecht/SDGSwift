/*
 Documentation.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Structure {

    /// Performs an action using the specified parameters.
    ///
    /// This is a second paragraph.
    ///
    /// # Primary Heading
    ///
    /// ## Secondary Heading
    ///
    /// ### Tertiary Heading
    ///
    /// Another Primary Heading
    /// =======================
    ///
    /// Another Secondary Heading
    /// -------------------------
    ///
    /// Asterisms:
    ///
    /// ***
    ///
    /// * * *
    ///
    /// ---
    ///
    /// ___
    ///
    /// This is a list:
    /// - First entry.
    /// - Second entry.
    ///
    /// This is also list:
    /// * First entry.
    /// * Second entry.
    ///
    /// And this is a list too:
    /// + First entry.
    /// + Second entry.
    ///
    /// And this is an ordered List:
    /// 1. First entry.
    /// 2. Second entry.
    ///
    /// There is something significant about `parameterOne`.
    ///
    /// And `let x = 1` contains a keyword.
    ///
    /// ```swift
    /// // This is an example.
    /// if try performAction(on: "1", with: "2") {
    ///     print("It worked.")
    /// }
    /// ```
    ///
    /// Here are **strong** and *emphasized*. (Or __strong__ and _emphasized_.)
    ///
    /// There are also [links](somewhere.com).
    ///
    /// - Warning: There is something to watch out for.
    ///
    /// - Parameters:
    ///     - parameterOne: The first parameter.
    ///     - parameterTwo: The second parameter.
    ///
    /// - Returns: A Boolean value.
    ///
    /// - Throws: An error.
    public func performAction(on parameterOne: String, with parameterTwo: String) throws -> Bool {
        return false
    }

    /// ...
    ///
    /// - Parameter parameterOne: The first parameter.
    /// - Parameter parameterTwo: The second parameter.
    public func withSeparateParameters(parameterOne: String, parameterTwo: String) throws -> Bool {
        return false
    }
}

/// A structure.
///
/// ```swift
/// // Some source.
/// ```
struct DocumentedStructure {
}
