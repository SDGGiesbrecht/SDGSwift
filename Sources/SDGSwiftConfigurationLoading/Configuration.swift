/*
 Configuration.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLocalization

extension Configuration {

    public class func load<C, L>(configuration: C.Type, named name: UserFacing<StrictString, L>, from directory: URL) throws -> C where C : Configuration, L : InputLocalization {
        // [_Warning: Rename this._]

        var configurationFile: URL?
        for localization in L.cases {
            let fileName = name.resolved(for: localization)
            let url = directory.appendingPathComponent("\(fileName).swift")
            if try url.checkResourceIsReachable() {
                configurationFile = url
            }
        }
        print(configurationFile)

        notImplementedYet()
        return C()
    }
}
