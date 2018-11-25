/*
 InitializerDeclSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

extension InitializerDeclSyntax : AccessControlled, Attributed, FunctionLike {

    internal var initializerAPI: InitializerAPI? {
        if ¬isPublic ∨ isUnavailable() {
            return nil
        }
        let arguments = parameters(forSubscript: false)
        if arguments.first?.label?.hasPrefix("_") == true {
            return nil
        }
        return InitializerAPI(
            documentation: documentation,
            isFailable: optionalMark ≠ nil,
            arguments: arguments,
            throws: throwsOrRethrowsKeyword ≠ nil)
    }
}
