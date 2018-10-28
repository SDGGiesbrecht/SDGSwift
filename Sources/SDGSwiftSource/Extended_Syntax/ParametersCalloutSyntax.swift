/*
 ParametersCalloutSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

public class ParametersCalloutSyntax : CalloutSyntax {

    internal required init(
        bullet: ExtendedTokenSyntax?,
        indent: ExtendedTokenSyntax?,
        name: ExtendedTokenSyntax,
        space: ExtendedTokenSyntax?,
        parameterName: ExtendedTokenSyntax?,
        colon: ExtendedTokenSyntax,
        contents: [ExtendedSyntax]) {

        super.init(bullet: bullet,
                   indent: indent,
                   name: name,
                   space: space,
                   parameterName: parameterName,
                   colon: colon,
                   contents: contents)

        for element in contents {
            if let list = element as? ListSyntax {
                for item in list.children {
                    print(type(of: item))
                    print(item)
                    #warning("Working here.")
                }
            }
        }
    }
}
