/*
 Resources 4.swift

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
    private static let xctest0: [UInt8] = [
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x4E, 0x53, 0x4E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69,
      0x6F, 0x6E, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x3A, 0x20,
      0x43, 0x75, 0x73, 0x74, 0x6F, 0x6D, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x43, 0x6F, 0x6E,
      0x76, 0x65, 0x72, 0x74, 0x69, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x45, 0x71, 0x75, 0x61, 0x74, 0x61, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x48, 0x61, 0x73, 0x68, 0x61, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x6E, 0x61, 0x6D, 0x65, 0x20,
      0x6E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x4E, 0x61, 0x6D,
      0x65, 0x3A, 0x20,
      0x4E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2E, 0x4E, 0x61,
      0x6D, 0x65, 0x2C, 0x20,
      0x6F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x3F, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x43, 0x65, 0x6E,
      0x74, 0x65, 0x72, 0x3A, 0x20,
      0x4E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x43, 0x65, 0x6E,
      0x74, 0x65, 0x72, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x61, 0x74, 0x69, 0x63, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x68, 0x61, 0x6E, 0x64, 0x6C, 0x65, 0x72, 0x3A, 0x20,
      0x48, 0x61, 0x6E, 0x64, 0x6C, 0x65, 0x72, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x6E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x43, 0x65, 0x6E,
      0x74, 0x65, 0x72, 0x3A, 0x20,
      0x4E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x43, 0x65, 0x6E,
      0x74, 0x65, 0x72, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x6E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x4E, 0x61, 0x6D,
      0x65, 0x3A, 0x20,
      0x4E, 0x6F, 0x74, 0x69, 0x66, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2E, 0x4E, 0x61,
      0x6D, 0x65, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x6F, 0x62, 0x73, 0x65, 0x72, 0x76, 0x65, 0x64, 0x4F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x3A,
      0x20,
      0x41, 0x6E, 0x79, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x4E, 0x53, 0x50,
      0x72, 0x65, 0x64, 0x69, 0x63, 0x61, 0x74, 0x65, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x3A, 0x20,
      0x43, 0x75, 0x73, 0x74, 0x6F, 0x6D, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x43, 0x6F, 0x6E,
      0x76, 0x65, 0x72, 0x74, 0x69, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x45, 0x71, 0x75, 0x61, 0x74, 0x61, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x48, 0x61, 0x73, 0x68, 0x61, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x70,
      0x72, 0x65, 0x64, 0x69, 0x63, 0x61, 0x74, 0x65, 0x3A, 0x20,
      0x4E, 0x53, 0x50,
      0x72, 0x65, 0x64, 0x69, 0x63, 0x61, 0x74, 0x65, 0x2C, 0x20,
      0x6F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x3F, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x61, 0x74, 0x69, 0x63, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x68, 0x61, 0x6E, 0x64, 0x6C, 0x65, 0x72, 0x3A, 0x20,
      0x48, 0x61, 0x6E, 0x64, 0x6C, 0x65, 0x72, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x6F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x70,
      0x72, 0x65, 0x64, 0x69, 0x63, 0x61, 0x74, 0x65, 0x3A, 0x20,
      0x4E, 0x53, 0x50,
      0x72, 0x65, 0x64, 0x69, 0x63, 0x61, 0x74, 0x65, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x20,
      0x3A, 0x20,
      0x43, 0x75, 0x73, 0x74, 0x6F, 0x6D, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x43, 0x6F, 0x6E,
      0x76, 0x65, 0x72, 0x74, 0x69, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x45, 0x71, 0x75, 0x61, 0x74, 0x61, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x4D, 0x61, 0x6E, 0x61, 0x67, 0x65, 0x61, 0x62, 0x6C, 0x65, 0x57, 0x61, 0x69, 0x74, 0x65,
      0x72, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x28, 0x66, 0x6F, 0x72, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x3A, 0x20,
      0x5B, 0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x5D, 0x2C, 0x20,
      0x74, 0x69, 0x6D, 0x65, 0x6F, 0x75, 0x74, 0x3A, 0x20,
      0x54, 0x69, 0x6D, 0x65, 0x49, 0x6E, 0x74, 0x65, 0x72, 0x76, 0x61, 0x6C, 0x2C, 0x20,
      0x65, 0x6E, 0x66, 0x6F, 0x72, 0x63, 0x65, 0x4F, 0x72, 0x64, 0x65, 0x72, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x61, 0x74, 0x69, 0x63, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x2D, 0x3E, 0x20,
      0x52, 0x65, 0x73, 0x75, 0x6C, 0x74, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x64, 0x65, 0x6C, 0x65, 0x67, 0x61, 0x74, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x44, 0x65, 0x6C, 0x65, 0x67, 0x61,
      0x74, 0x65, 0x3F, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x64, 0x65, 0x6C, 0x65, 0x67, 0x61, 0x74, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x44, 0x65, 0x6C, 0x65, 0x67, 0x61,
      0x74, 0x65, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x66, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x65, 0x64, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x3A, 0x20,
      0x5B, 0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x5D, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x3D, 0x3D, 0x28, 0x6C, 0x68, 0x73, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x2C, 0x20,
      0x72, 0x68, 0x73, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x29, 0x20,
      0x2D, 0x3E, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x40,
      0x64, 0x69, 0x73, 0x63, 0x61, 0x72, 0x64, 0x61, 0x62, 0x6C, 0x65, 0x52, 0x65, 0x73, 0x75,
      0x6C, 0x74, 0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x28, 0x66, 0x6F, 0x72, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x3A, 0x20,
      0x5B, 0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x5D, 0x2C, 0x20,
      0x74, 0x69, 0x6D, 0x65, 0x6F, 0x75, 0x74, 0x3A, 0x20,
      0x54, 0x69, 0x6D, 0x65, 0x49, 0x6E, 0x74, 0x65, 0x72, 0x76, 0x61, 0x6C, 0x2C, 0x20,
      0x65, 0x6E, 0x66, 0x6F, 0x72, 0x63, 0x65, 0x4F, 0x72, 0x64, 0x65, 0x72, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x61, 0x74, 0x69, 0x63, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x2D, 0x3E, 0x20,
      0x52, 0x65, 0x73, 0x75, 0x6C, 0x74, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x6E, 0x61, 0x6D, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x43, 0x6C, 0x61, 0x73, 0x73, 0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x43, 0x6C, 0x61, 0x73, 0x73, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x70,
      0x65, 0x72, 0x66, 0x6F, 0x72, 0x6D, 0x28, 0x5F, 0x20,
      0x72, 0x75, 0x6E, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x72, 0x75, 0x6E, 0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x73, 0x65, 0x74, 0x55, 0x70,
      0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x73, 0x65, 0x74, 0x55, 0x70,
      0x57, 0x69, 0x74, 0x68, 0x45, 0x72, 0x72, 0x6F, 0x72, 0x28, 0x29, 0x20,
      0x74, 0x68, 0x72, 0x6F, 0x77, 0x73, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x61, 0x72, 0x44, 0x6F, 0x77, 0x6E, 0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x61, 0x72, 0x44, 0x6F, 0x77, 0x6E, 0x57, 0x69, 0x74, 0x68, 0x45, 0x72, 0x72,
      0x6F, 0x72, 0x28, 0x29, 0x20,
      0x74, 0x68, 0x72, 0x6F, 0x77, 0x73, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x20,
      0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x4F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x2C, 0x20,
      0x50,
      0x65, 0x72, 0x66, 0x6F, 0x72, 0x6D, 0x61, 0x6E, 0x63, 0x65, 0x4D, 0x65, 0x74, 0x65, 0x72,
      0x44, 0x65, 0x6C, 0x65, 0x67, 0x61, 0x74, 0x65, 0x2C, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x44, 0x65, 0x6C, 0x65, 0x67, 0x61,
      0x74, 0x65, 0x2C, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x73, 0x65, 0x74, 0x55, 0x70,
      0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x61, 0x72, 0x44, 0x6F, 0x77, 0x6E, 0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x64, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x6E, 0x61, 0x6D, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x2C, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x6C, 0x6F, 0x73, 0x75, 0x72, 0x65, 0x3A, 0x20,
      0x40,
      0x65, 0x73, 0x63, 0x61, 0x70,
      0x69, 0x6E, 0x67, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x43, 0x6C, 0x6F, 0x73, 0x75,
      0x72, 0x65, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x63, 0x6F, 0x6E, 0x74, 0x69, 0x6E, 0x75, 0x65, 0x41, 0x66, 0x74, 0x65, 0x72, 0x46, 0x61,
      0x69, 0x6C, 0x75, 0x72, 0x65, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x61, 0x64, 0x64, 0x54, 0x65, 0x61, 0x72, 0x64, 0x6F, 0x77, 0x6E, 0x42, 0x6C, 0x6F, 0x63,
      0x6B, 0x28, 0x5F, 0x20,
      0x62, 0x6C, 0x6F, 0x63, 0x6B, 0x3A, 0x20,
      0x40,
      0x65, 0x73, 0x63, 0x61, 0x70,
      0x69, 0x6E, 0x67, 0x20,
      0x28, 0x29, 0x20,
      0x2D, 0x3E, 0x20,
      0x56, 0x6F, 0x69, 0x64, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x69, 0x6E, 0x76, 0x6F, 0x6B, 0x65, 0x54, 0x65, 0x73, 0x74, 0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x72, 0x65, 0x63, 0x6F, 0x72, 0x64, 0x46, 0x61, 0x69, 0x6C, 0x75, 0x72, 0x65, 0x28, 0x77,
      0x69, 0x74, 0x68, 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x2C, 0x20,
      0x69, 0x6E, 0x46, 0x69, 0x6C, 0x65, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x50,
      0x61, 0x74, 0x68, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x2C, 0x20,
      0x61, 0x74, 0x4C, 0x69, 0x6E, 0x65, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x4E, 0x75, 0x6D, 0x62, 0x65, 0x72, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x2C, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x65, 0x64, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x52, 0x75, 0x6E, 0x20,
      0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x20,
      0x7B, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x3A, 0x20,
      0x43, 0x75, 0x73, 0x74, 0x6F, 0x6D, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x43, 0x6F, 0x6E,
      0x76, 0x65, 0x72, 0x74, 0x69, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x45, 0x71, 0x75, 0x61, 0x74, 0x61, 0x62, 0x6C, 0x65, 0x2C, 0x20,
      0x48, 0x61, 0x73, 0x68, 0x61, 0x62, 0x6C, 0x65, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x61, 0x74, 0x69, 0x63, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x61, 0x73, 0x73, 0x65, 0x72, 0x74, 0x46, 0x6F, 0x72, 0x4F, 0x76, 0x65, 0x72, 0x46, 0x75,
      0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x44, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x65, 0x64, 0x46, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x6D, 0x65, 0x6E,
      0x74, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x69, 0x73, 0x49, 0x6E, 0x76, 0x65, 0x72, 0x74, 0x65, 0x64, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x73, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x3D, 0x3D, 0x28, 0x6C, 0x68, 0x73, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2C, 0x20,
      0x72, 0x68, 0x73, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x29, 0x20,
      0x2D, 0x3E, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x66, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x28, 0x5F, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x61, 0x74, 0x69, 0x63, 0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x3D, 0x20,
      0x78, 0x2C, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x3D, 0x20,
      0x78, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x68, 0x61, 0x73, 0x68, 0x28, 0x69, 0x6E, 0x74, 0x6F, 0x20,
      0x68, 0x61, 0x73, 0x68, 0x65, 0x72, 0x3A, 0x20,
      0x69, 0x6E, 0x6F, 0x75, 0x74, 0x20,
      0x48, 0x61, 0x73, 0x68, 0x65, 0x72, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x64, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x74, 0x65, 0x73, 0x74, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x65, 0x78, 0x65, 0x63, 0x75, 0x74, 0x69, 0x6F, 0x6E, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A,
      0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x66, 0x61, 0x69, 0x6C, 0x75, 0x72, 0x65, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x68, 0x61, 0x73, 0x42, 0x65, 0x65, 0x6E, 0x53, 0x6B, 0x69, 0x70,
      0x70,
      0x65, 0x64, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x68, 0x61, 0x73, 0x53, 0x75, 0x63, 0x63, 0x65, 0x65, 0x64, 0x65, 0x64, 0x3A, 0x20,
      0x42, 0x6F, 0x6F, 0x6C, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x73, 0x6B, 0x69, 0x70,
      0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x73, 0x74, 0x61, 0x72, 0x74, 0x44, 0x61, 0x74, 0x65, 0x3A, 0x20,
      0x44, 0x61, 0x74, 0x65, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x73, 0x74, 0x6F, 0x70,
      0x44, 0x61, 0x74, 0x65, 0x3A, 0x20,
      0x44, 0x61, 0x74, 0x65, 0x3F, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x44, 0x75, 0x72, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x54, 0x69, 0x6D, 0x65, 0x49, 0x6E, 0x74, 0x65, 0x72, 0x76, 0x61, 0x6C, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x6F, 0x74, 0x61, 0x6C, 0x44, 0x75, 0x72, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x54, 0x69, 0x6D, 0x65, 0x49, 0x6E, 0x74, 0x65, 0x72, 0x76, 0x61, 0x6C, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x6F, 0x74, 0x61, 0x6C, 0x46, 0x61, 0x69, 0x6C, 0x75, 0x72, 0x65, 0x43, 0x6F, 0x75,
      0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x75, 0x6E, 0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x65, 0x64, 0x45, 0x78, 0x63, 0x65, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x43, 0x6F, 0x75, 0x6E, 0x74, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x73, 0x74, 0x61, 0x72, 0x74, 0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x73, 0x74, 0x6F, 0x70,
      0x28, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x20,
      0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x69, 0x6E, 0x69, 0x74, 0x28, 0x6E, 0x61, 0x6D, 0x65, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x73, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x61, 0x64, 0x64, 0x54, 0x65, 0x73, 0x74, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x63, 0x6C, 0x61, 0x73, 0x73, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x52, 0x75, 0x6E, 0x20,
      0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x76, 0x61, 0x72, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x73, 0x20,
      0x7B, 0x20,
      0x67, 0x65, 0x74, 0x20,
      0x7D, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x61, 0x64, 0x64, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x52, 0x75, 0x6E, 0x29, 0x20,
      0x7B, 0x7D, 0x0A, 0x7D, 0x0A, 0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x70,
      0x72, 0x6F, 0x74, 0x6F, 0x63, 0x6F, 0x6C, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x44, 0x65, 0x6C, 0x65, 0x67, 0x61,
      0x74, 0x65, 0x20,
      0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x4F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x6E, 0x65, 0x73, 0x74, 0x65, 0x64, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x28, 0x5F, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x2C, 0x20,
      0x77, 0x61, 0x73, 0x49, 0x6E, 0x74, 0x65, 0x72, 0x72, 0x75, 0x70,
      0x74, 0x65, 0x64, 0x42, 0x79, 0x54, 0x69, 0x6D, 0x65, 0x64, 0x4F, 0x75, 0x74, 0x57, 0x61,
      0x69, 0x74, 0x65, 0x72, 0x20,
      0x6F, 0x75, 0x74, 0x65, 0x72, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x28, 0x5F, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x2C, 0x20,
      0x64, 0x69, 0x64, 0x46, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x49, 0x6E, 0x76, 0x65, 0x72,
      0x74, 0x65, 0x64, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x28, 0x5F, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x2C, 0x20,
      0x64, 0x69, 0x64, 0x54, 0x69, 0x6D, 0x65, 0x6F, 0x75, 0x74, 0x57, 0x69, 0x74, 0x68, 0x55,
      0x6E, 0x66, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x65, 0x64, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x20,
      0x75, 0x6E, 0x66, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x65, 0x64, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x3A, 0x20,
      0x5B, 0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x5D, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x28, 0x5F, 0x20,
      0x77, 0x61, 0x69, 0x74, 0x65, 0x72, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x57, 0x61, 0x69, 0x74, 0x65, 0x72, 0x2C, 0x20,
      0x66, 0x75, 0x6C, 0x66, 0x69, 0x6C, 0x6C, 0x6D, 0x65, 0x6E, 0x74, 0x44, 0x69, 0x64, 0x56,
      0x69, 0x6F, 0x6C, 0x61, 0x74, 0x65, 0x4F, 0x72, 0x64, 0x65, 0x72, 0x69, 0x6E, 0x67, 0x43,
      0x6F, 0x6E, 0x73, 0x74, 0x72, 0x61, 0x69, 0x6E, 0x74, 0x73, 0x46, 0x6F, 0x72, 0x20,
      0x65, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2C, 0x20,
      0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x64, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x45, 0x78, 0x70,
      0x65, 0x63, 0x74, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x29, 0x0A, 0x7D, 0x0A, 0x70,
      0x75, 0x62, 0x6C, 0x69, 0x63, 0x20,
      0x70,
      0x72, 0x6F, 0x74, 0x6F, 0x63, 0x6F, 0x6C, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x4F, 0x62, 0x73, 0x65, 0x72, 0x76, 0x61, 0x74, 0x69,
      0x6F, 0x6E, 0x20,
      0x3A, 0x20,
      0x41, 0x6E, 0x79, 0x4F, 0x62, 0x6A, 0x65, 0x63, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x42, 0x75, 0x6E, 0x64, 0x6C, 0x65, 0x44, 0x69, 0x64, 0x46, 0x69,
      0x6E, 0x69, 0x73, 0x68, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x42, 0x75, 0x6E, 0x64, 0x6C, 0x65, 0x3A, 0x20,
      0x42, 0x75, 0x6E, 0x64, 0x6C, 0x65, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x42, 0x75, 0x6E, 0x64, 0x6C, 0x65, 0x57, 0x69, 0x6C, 0x6C, 0x53,
      0x74, 0x61, 0x72, 0x74, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x42, 0x75, 0x6E, 0x64, 0x6C, 0x65, 0x3A, 0x20,
      0x42, 0x75, 0x6E, 0x64, 0x6C, 0x65, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x2C, 0x20,
      0x64, 0x69, 0x64, 0x46, 0x61, 0x69, 0x6C, 0x57, 0x69, 0x74, 0x68, 0x44, 0x65, 0x73, 0x63,
      0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x64, 0x65, 0x73, 0x63, 0x72, 0x69, 0x70,
      0x74, 0x69, 0x6F, 0x6E, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x2C, 0x20,
      0x69, 0x6E, 0x46, 0x69, 0x6C, 0x65, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x50,
      0x61, 0x74, 0x68, 0x3A, 0x20,
      0x53, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x3F, 0x2C, 0x20,
      0x61, 0x74, 0x4C, 0x69, 0x6E, 0x65, 0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x4E, 0x75, 0x6D, 0x62, 0x65, 0x72, 0x3A, 0x20,
      0x49, 0x6E, 0x74, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x44, 0x69, 0x64, 0x46, 0x69, 0x6E, 0x69,
      0x73, 0x68, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x57, 0x69, 0x6C, 0x6C, 0x53, 0x74, 0x61,
      0x72, 0x74, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x43, 0x61, 0x73, 0x65, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x44, 0x69, 0x64, 0x46, 0x69, 0x6E,
      0x69, 0x73, 0x68, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x29, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x75, 0x6E, 0x63, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x57, 0x69, 0x6C, 0x6C, 0x53, 0x74,
      0x61, 0x72, 0x74, 0x28, 0x5F, 0x20,
      0x74, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x3A, 0x20,
      0x58, 0x43, 0x54, 0x65, 0x73, 0x74, 0x53, 0x75, 0x69, 0x74, 0x65, 0x29, 0x0A, 0x7D,
    ]
    internal static var xctest: String {
      return String(
        data: Data(([xctest0] as [[UInt8]]).lazy.joined()),
        encoding: String.Encoding.utf8
      )!
    }
  #else
    internal static var xctest: String {
      return String(
        data: try! Data(
          contentsOf: moduleBundle.url(forResource: "XCTest", withExtension: "txt")!,
          options: [.mappedIfSafe]
        ),
        encoding: String.Encoding.utf8
      )!
    }
  #endif
}
