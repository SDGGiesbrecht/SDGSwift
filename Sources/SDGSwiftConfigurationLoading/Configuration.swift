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

    /// Loads the configuration in the specified directory with the specified file name.
    ///
    /// - Parameters:
    ///     - fileName: A localized file name (without “.swift”). Any of the localized names will be detected. If several are present, which one gets loaded is undefined.
    ///     - directory: The directory where the configuration is located.
    ///
    /// - Returns: The loaded configuration if one is present, otherwise the default configuration.
    public class func loadConfiguration<L>(named fileName: UserFacing<StrictString, L>, from directory: URL) throws -> Self where L : InputLocalization {
        // [_Warning: Rename this._]

        var configurationFile: URL?
        for localization in L.cases {
            let resolvedFileName = fileName.resolved(for: localization)
            let url = directory.appendingPathComponent("\(resolvedFileName).swift")
            if try url.checkResourceIsReachable() {
                configurationFile = url
            }
        }
        print(configurationFile)

        notImplementedYet()
        return self.init()
    }
}
