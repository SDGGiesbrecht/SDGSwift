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

    /// Not part of following documentation.
    // An intervening comment.
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
    /// #### Level 4 Heading
    ///
    /// ##### Level 5 Heading
    ///
    /// ###### Level 6 Heading
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
    /// ```
    /// let unmarked = true
    /// ```
    ///
    /// ```other
    /// This is unidentified.
    /// ```
    ///
    /// And empty:
    ///
    /// ```swift
    /// ```
    ///
    /// Here are **strong** and *emphasized*. (Or __strong__ and _emphasized_.)
    ///
    /// There are also [links](somewhere.com).
    ///
    /// And ![images](somewhere.com/image).
    ///
    /// > And someone said this.
    ///
    /// > ―Someone.
    ///
    /// Paragraphs
    /// may
    /// be
    /// broken
    /// up
    /// .
    ///
    /// Lines  
    /// may be split.
    ///
    /// - Warning: There is something to watch out for.
    ///
    /// - Attention: ...
    ///
    /// - Author: ...
    ///
    /// - Authors: ...
    ///
    /// - Bug: ...
    ///
    /// - Complexity: ...
    ///
    /// - Copyright: ...
    ///
    /// - Date: ...
    ///
    /// - Experiment: ...
    ///
    /// - Important: ...
    ///
    /// - Invariant: ...
    ///
    /// - LocalizationKey: ...
    ///
    /// - MutatingVariant: ...
    ///
    /// - NonmutatingVariant: ...
    ///
    /// - Note: ...
    ///
    /// - Postcondition: ...
    ///
    /// - Precondition: ...
    ///
    /// - Remark: ...
    ///
    /// - Remarks: ...
    ///
    /// - Requires: ...
    ///
    /// - SeeAlso: ...
    ///
    /// - Since: ...
    ///
    /// - Tag: ...
    ///
    /// - ToDo: ...
    ///
    /// - Version: ...
    ///
    /// - Keyword: ...
    ///
    /// - Recommended: ...
    ///
    /// - RecommendedOver: ...
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

    /// Not part of the following documentation.

    /// ...
    ///
    /// - Parameter parameterOne: The first parameter.
    /// - Parameter parameterTwo: The second parameter.
    public func withSeparateParameters(parameterOne: String, parameterTwo: String) throws -> Bool {
        return false
    }

    /**
     Documented with the block style.

     Specified:

     ```swift
     func doSomething()
     ```

     Unspecified, Swift:

     ```
     func doSomething()
     ```

     Unspecified, not Swift:

     ```
     This cannot compile.
     ```

     Not Swift:

     ```not‐swift
     func doSomething()
     ```
     */
    public func documentedWithBlockStyle() {}
}

/// A structure.
///
/// ```swift
/// // Some source.
/// ```
struct DocumentedStructure {
}
