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

import SDGLogic
import SDGPersistence
import SDGExternalProcess

import SDGSwift
import SDGSwiftPackageManager
import SDGSwiftSource

ProcessInfo.applicationIdentifier = "ca.solideogloria.SDGSwift.refresh‐core‐libraries"

let branchName = "swift\u{2D}\(SwiftCompiler._standardLibraryVersion.string(droppingEmptyPatch: true))\u{2D}RELEASE"
let modules: [String: (url: String, path: String)] = [
    "Swift": ("swift", "stdlib/public/core"),
    "Foundation": ("swift\u{2D}corelibs\u{2D}foundation", "Foundation"),
    "Dispatch": ("swift\u{2D}corelibs\u{2D}libdispatch", "src/swift"),
    "XCTest": ("swift\u{2D}corelibs\u{2D}xctest", "Sources/XCTest/Public")
]

let resources = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Resources/SDGSwiftSource")

moduleEnumeration: for (name, module) in modules.sorted(by: { $0.0 < $1.0 }) {
    let gitHubRepository = SDGSwift.Package(url: URL(string: "https://github.com/apple/" + module.url)!)
    let cloneURL = FileManager.default.url(in: .temporary, at: module.url)
    defer { try? FileManager.default.removeItem(at: cloneURL) }
    _ = try PackageRepository(cloning: gitHubRepository, to: cloneURL, shallow: true, reportProgress: { print($0) })
    try Shell.default.run(command: ["git", "checkout"], in: cloneURL, reportProgress: { print($0) })

    var interface: [String] = []

    var sources = try FileManager.default.deepFileEnumeration(in: cloneURL.appendingPathComponent(module.path))
    sources = sources.filter { $0.pathExtension == "swift" }
    for source in sources {
        try autoreleasepool {
            var normalized = try StrictString(from: source)

            // #workaround(SwiftSyntax 0.40200.0, SwiftSyntax cannot parse “#error”.)
            normalized.replaceMatches(for: "#error", with: "error")

            try normalized.save(to: source)
        }
    }

    do {
        let api = try ModuleAPI(documentation: nil, declaration: SyntaxFactory.makeBlankFunctionCallExpr(), sources: sources)
        APIElement.module(api).appendInheritables(to: &interface)
    } catch {
        fatalError("\(error)")
    }
    interface = interface.map({ $0.replacingMatches(for: "= default", with: "= x") })

    let resource = resources.appendingPathComponent(name).appendingPathExtension("swift")
    try interface.joined(separator: "\n").save(to: resource)
}
