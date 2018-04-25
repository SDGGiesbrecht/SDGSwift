/*
 SDGCornerstone.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGExternalProcess

extension ExternalProcess {

    internal convenience init?<S>(searching locations: S, commandName: String?, validate: (_ process: ExternalProcess) -> Bool) where S : Sequence, S.Element == URL {
        // [_Workaround: Belongs in SDGExternalProcess (SDGCornerstone 0.9.0)_]

        func checkLocation(_ location: URL, validate: (ExternalProcess) -> Bool) -> Bool {
            var isDirectory: ObjCBool = false
            if ¬FileManager.default.fileExists(atPath: location.path, isDirectory: &isDirectory) {
                return false
            }
            if isDirectory.boolValue {
                return false
            }
            if ¬FileManager.default.isExecutableFile(atPath: location.path) {
                return false
            }
            let possible = ExternalProcess(at: location)
            if ¬validate(possible) {
                return false
            }
            return true
        }

        for location in locations {
            if checkLocation(location, validate: validate) {
                self.init(at: location)
                return
            }
        }

        if let name = commandName,
            let path = try? Shell.default.run(command: ["which", name]) {
            let location = URL(fileURLWithPath: path)
            if checkLocation(location, validate: validate) {
                self.init(at: location)
                return
            }
        }

        return nil
    }
}
