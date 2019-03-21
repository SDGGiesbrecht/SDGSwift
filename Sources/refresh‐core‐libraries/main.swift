/*
 main.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGPersistence
import SDGExternalProcess

import SDGSwift
import SDGSwiftPackageManager
import SDGSwiftSource

do {
    ProcessInfo.applicationIdentifier = "ca.solideogloria.SDGSwift.refresh‐core‐libraries"

    let branchName = "swift\u{2D}\(SwiftCompiler._standardLibraryVersion.string(droppingEmptyPatch: true))\u{2D}RELEASE"
    let modules: [String: (url: String, path: String)] = [
        "Swift": ("swift", "stdlib/public/core"),
        "Foundation": ("swift\u{2D}corelibs\u{2D}foundation", "Foundation"),
        "Dispatch": ("swift\u{2D}corelibs\u{2D}libdispatch", "src/swift"),
        "XCTest": ("swift\u{2D}corelibs\u{2D}xctest", "Sources/XCTest/Public")
    ]

    let resources = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Resources/SDGSwiftSource/Core Libraries")

    moduleEnumeration: for (name, module) in modules.sorted(by: { $0.0 < $1.0 }) {
        let gitHubRepository = URL(string: "https://github.com/apple/" + module.url)!
        try FileManager.default.withTemporaryDirectory(appropriateFor: URL(fileURLWithPath: #file)) { temporaryDirectory in
            let cloneURL = temporaryDirectory.appendingPathComponent(module.url)
            try Shell.default.run(command: [
                "git", "clone",
                gitHubRepository.absoluteString,
                cloneURL.path,
                "\u{2D}\u{2D}branch", branchName,
                "\u{2D}\u{2D}depth", "1"
                ], reportProgress: { print($0) })

            var interface: [String] = []

            var sources = try FileManager.default.deepFileEnumeration(in: cloneURL.appendingPathComponent(module.path))
            if name == "Swift" {
                for source in sources.filter({ $0.pathExtension == "gyb" }) {
                    try autoreleasepool {
                        var normalized = try StrictString(from: source)
                        normalized.replaceMatches(for: "CMAKE_SIZEOF_VOID_P", with: "64")
                        try normalized.save(to: source)

                        try Shell.default.run(command: [
                            "utils/gyb",
                            source.path,
                            "\u{2D}o", source.deletingPathExtension().path
                            ], in: cloneURL)
                    }
                }
                sources = try FileManager.default.deepFileEnumeration(in: cloneURL.appendingPathComponent(module.path))
            }

            sources = sources.filter { $0.pathExtension == "swift" }
            for source in sources {
                try autoreleasepool {
                    var normalized = try StrictString(from: source)

                    // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax cannot parse “#error”.)
                    normalized.replaceMatches(for: "#error", with: "error")

                    try normalized.save(to: source)
                }
            }

            let api = try ModuleAPI(documentation: nil, declaration: SyntaxFactory.makeBlankFunctionCallExpr(), sources: sources)
            APIElement.module(api).appendInheritables(to: &interface)
            interface = interface.map({ $0.replacingMatches(for: "= default", with: "= x") })

            let resource = resources.appendingPathComponent(name).appendingPathExtension("txt")
            try interface.joined(separator: "\n").save(to: resource)
        }
    }
} catch {
    fatalError("\(error)")
}
