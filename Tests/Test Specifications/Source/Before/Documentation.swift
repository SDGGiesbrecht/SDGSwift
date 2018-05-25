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
    /// # Primary Heading.
    ///
    /// ## Secondary Heading.
    ///
    /// ### Tertiary Heading.
    ///
    /// Another Primary Heading
    /// =======================
    ///
    /// Another Secondary Heading
    /// -------------------------
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
    /// There is something significant about `parameterOne`.
    ///
    /// ```swift
    /// // This is an example.
    /// if try performAction(on: "1", with: "2") {
    ///     print("It worked.")
    /// }
    /// ```
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
}
