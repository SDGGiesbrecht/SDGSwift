/*
 main.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// #workaround(Swift 5.3, SwiftSyntax won’t compile.)
#if (os(Windows) || os(WASI) || os(Android))
  fatalError("SwiftSyntax is unavailable.")
#else
  import Foundation

  import SDGControlFlow
  import SDGLogic
  import SDGCollections
  import SDGText
  import SDGPersistence
  import SDGExternalProcess
  import SDGVersioning

  import SwiftSyntax

  import SDGSwift
  import SDGSwiftPackageManager
  import SDGSwiftSource

  do {
    ProcessInfo.applicationIdentifier = "ca.solideogloria.SDGSwift.refresh‐core‐libraries"

    let currentVersion = SwiftCompiler.version(forConstraints: Version(Int.min)...Version(Int.max))!
    let branchName = "swift\u{2D}\(currentVersion.string(droppingEmptyPatch: true))\u{2D}RELEASE"
    let modules: [String: (url: String, path: String)] = [
      "Swift": ("swift", "stdlib/public/core"),
      "Foundation": ("swift\u{2D}corelibs\u{2D}foundation", "Foundation"),
      "Dispatch": ("swift\u{2D}corelibs\u{2D}libdispatch", "src/swift"),
      "XCTest": ("swift\u{2D}corelibs\u{2D}xctest", "Sources/XCTest/Public"),
    ]

    let resources = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
      .deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent(
        "Resources/SDGSwiftSource/Core Libraries"
      )

    moduleEnumeration: for (name, module) in modules.sorted(by: { $0.0 < $1.0 }) {
      let gitHubRepository = URL(string: "https://github.com/apple/" + module.url)!
      try FileManager.default
        .withTemporaryDirectory(
          appropriateFor: URL(fileURLWithPath: #filePath)
        ) { temporaryDirectory in
          let cloneURL = temporaryDirectory.appendingPathComponent(module.url)
          _ = try Shell.default.run(
            command: [
              "git", "clone",
              gitHubRepository.absoluteString,
              cloneURL.path,
              "\u{2D}\u{2D}branch", branchName,
              "\u{2D}\u{2D}depth", "1",
            ],
            reportProgress: { print($0) }
          ).get()

          var interface: [String] = []

          var sources = try FileManager.default.deepFileEnumeration(
            in: cloneURL.appendingPathComponent(module.path)
          )
          if name == "Swift" {
            for source in sources.filter({ $0.pathExtension == "gyb" }) {
              try purgingAutoreleased {
                var normalized = try StrictString(from: source)
                normalized.replaceMatches(for: "CMAKE_SIZEOF_VOID_P", with: "64")
                try normalized.save(to: source)

                _ = try Shell.default.run(
                  command: [
                    "utils/gyb",
                    source.path,
                    "\u{2D}o", source.deletingPathExtension().path,
                  ],
                  in: cloneURL
                ).get()
              }
            }
            sources = try FileManager.default.deepFileEnumeration(
              in: cloneURL.appendingPathComponent(module.path)
            )
          }

          sources = sources.filter { $0.pathExtension == "swift" }
          sources = sources.sorted()
          for source in sources {
            try purgingAutoreleased {
              var normalized = try StrictString(from: source)
              if source.lastPathComponent == "Array.swift"
                ∨ source.lastPathComponent == "String.swift"
              {
                // #workaround(cmark 0.0.50200, Indexing bug leads to infinite loop?)
                normalized.replaceMatches(
                  for: "///".scalars
                    + RepetitionPattern(ConditionalPattern<Unicode.Scalar>({ $0 ≠ "\n" }))
                    + "\n".scalars,
                  with: "\n".scalars
                )
              }
              try normalized.save(to: source)
            }
          }

          let api = try ModuleAPI(
            documentation: [],
            declaration: SyntaxFactory.makeBlankFunctionCallExpr(),
            sources: sources
          )
          APIElement.module(api).appendInheritables(to: &interface)
          interface = interface.map({ $0.replacingMatches(for: "= default", with: "= x") })

          let resource = resources.appendingPathComponent(name).appendingPathExtension("txt")
          try interface.joined(separator: "\n").save(to: resource)
        }
    }
  } catch {
    fatalError("\(error)")
  }
#endif
