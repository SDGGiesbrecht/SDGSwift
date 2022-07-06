/*
 Resources 1.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

extension Resources {
  #if os(WASI)
    private static let packageSwift0: [UInt8] = [
      0x2F, 0x2F, 0x20,
      0x73, 0x77, 0x69, 0x66, 0x74, 0x2D, 0x74, 0x6F, 0x6F, 0x6C, 0x73, 0x2D, 0x76, 0x65, 0x72,
      0x73, 0x69, 0x6F, 0x6E, 0x3A, 0x5B, 0x2A, 0x74, 0x6F, 0x6F, 0x6C, 0x73, 0x20,
      0x76, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x2A, 0x5D, 0x0A, 0x0A, 0x69, 0x6D, 0x70,
      0x6F, 0x72, 0x74, 0x20,
      0x50,
      0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x0A, 0x0A, 0x6C, 0x65, 0x74, 0x20,
      0x70,
      0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x20,
      0x3D, 0x20,
      0x50,
      0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x28, 0x0A, 0x20,
      0x20,
      0x6E, 0x61, 0x6D, 0x65, 0x3A, 0x20,
      0x22, 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x75, 0x72, 0x65, 0x22, 0x2C, 0x0A, 0x20,
      0x20,
      0x70,
      0x6C, 0x61, 0x74, 0x66, 0x6F, 0x72, 0x6D, 0x73, 0x3A, 0x20,
      0x5B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x2E, 0x6D, 0x61, 0x63, 0x4F, 0x53, 0x28, 0x2E, 0x76, 0x5B, 0x2A, 0x6D, 0x61, 0x63, 0x4F,
      0x53, 0x2A, 0x5D, 0x29, 0x0A, 0x20,
      0x20,
      0x5D, 0x2C, 0x0A, 0x20,
      0x20,
      0x64, 0x65, 0x70,
      0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x69, 0x65, 0x73, 0x3A, 0x20,
      0x5B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x2E, 0x70,
      0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x28, 0x5B, 0x2A, 0x70,
      0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x20,
      0x6E, 0x61, 0x6D, 0x65, 0x2A, 0x5D, 0x75, 0x72, 0x6C, 0x3A, 0x20,
      0x22, 0x5B, 0x2A, 0x55, 0x52, 0x4C, 0x2A, 0x5D, 0x22, 0x2C, 0x20,
      0x2E, 0x65, 0x78, 0x61, 0x63, 0x74, 0x28, 0x22, 0x5B, 0x2A, 0x76, 0x65, 0x72, 0x73, 0x69,
      0x6F, 0x6E, 0x2A, 0x5D, 0x22, 0x29, 0x29, 0x2C, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x5B, 0x2A, 0x70,
      0x61, 0x63, 0x6B, 0x61, 0x67, 0x65, 0x73, 0x2A, 0x5D, 0x2C, 0x0A, 0x20,
      0x20,
      0x5D, 0x2C, 0x0A, 0x20,
      0x20,
      0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x73, 0x3A, 0x20,
      0x5B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x2E, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x28, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x6E, 0x61, 0x6D, 0x65, 0x3A, 0x20,
      0x22, 0x63, 0x6F, 0x6E, 0x66, 0x69, 0x67, 0x75, 0x72, 0x65, 0x22, 0x2C, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x64, 0x65, 0x70,
      0x65, 0x6E, 0x64, 0x65, 0x6E, 0x63, 0x69, 0x65, 0x73, 0x3A, 0x20,
      0x5B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x5B, 0x2A, 0x70,
      0x72, 0x6F, 0x64, 0x75, 0x63, 0x74, 0x2A, 0x5D, 0x2C, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x5B, 0x2A, 0x70,
      0x72, 0x6F, 0x64, 0x75, 0x63, 0x74, 0x73, 0x2A, 0x5D, 0x2C, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x5D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x29, 0x0A, 0x20,
      0x20,
      0x5D, 0x0A, 0x29, 0x0A,
    ]
    internal static var packageSwift: String {
      return String(
        data: Data(([packageSwift0] as [[UInt8]]).lazy.joined()),
        encoding: String.Encoding.utf8
      )!
    }
  #else
    internal static var packageSwift: String {
      return String(
        data: try! Data(
          contentsOf: moduleBundle.url(forResource: "Package.swift", withExtension: "txt")!,
          options: [.mappedIfSafe]
        ),
        encoding: String.Encoding.utf8
      )!
    }
  #endif
}
