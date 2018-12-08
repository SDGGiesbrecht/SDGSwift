/*
 ConformanceAPI.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class ConformanceAPI : APIElement {

    // MARK: - Initialization

    internal init(type: TypeSyntax) {
        self.type = type.normalized()
        super.init(documentation: nil)
    }

    // MARK: - Properties

    private let type: TypeSyntax

    // MARK: - APIElement

    public override var name: Syntax {
        return type
    }

    public override var declaration: Syntax? {
        return nil
    }

    public override var summary: [String] {
        var result = name.source()
        if let constraints = self.constraints {
            result += constraints.source()
        }
        appendCompilationConditions(to: &result)
        return [result]
    }
}
