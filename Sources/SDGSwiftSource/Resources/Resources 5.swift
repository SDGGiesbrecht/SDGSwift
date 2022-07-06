/*
 Resources 5.swift

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
    private static let syntaxHighlighting0: [UInt8] = [
      0x2F, 0x2A, 0x0A, 0x20,
      0x53, 0x79, 0x6E, 0x74, 0x61, 0x78, 0x20,
      0x48, 0x69, 0x67, 0x68, 0x6C, 0x69, 0x67, 0x68, 0x74, 0x69, 0x6E, 0x67, 0x2E, 0x63, 0x73,
      0x73, 0x0A, 0x0A, 0x20,
      0x54, 0x68, 0x69, 0x73, 0x20,
      0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0x20,
      0x66, 0x69, 0x6C, 0x65, 0x20,
      0x69, 0x73, 0x20,
      0x70,
      0x61, 0x72, 0x74, 0x20,
      0x6F, 0x66, 0x20,
      0x74, 0x68, 0x65, 0x20,
      0x53, 0x44, 0x47, 0x53, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x6F, 0x70,
      0x65, 0x6E, 0x20,
      0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0x20,
      0x70,
      0x72, 0x6F, 0x6A, 0x65, 0x63, 0x74, 0x2E, 0x0A, 0x20,
      0x68, 0x74, 0x74, 0x70,
      0x73, 0x3A, 0x2F, 0x2F, 0x73, 0x64, 0x67, 0x67, 0x69, 0x65, 0x73, 0x62, 0x72, 0x65, 0x63,
      0x68, 0x74, 0x2E, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2E, 0x69, 0x6F, 0x2F, 0x53, 0x44,
      0x47, 0x53, 0x77, 0x69, 0x66, 0x74, 0x0A, 0x0A, 0x20,
      0x43, 0x6F, 0x70,
      0x79, 0x72, 0x69, 0x67, 0x68, 0x74, 0x20,
      0xC2, 0xA9, 0x32, 0x30,
      0x31, 0x38, 0xE2, 0x80,
      0x93, 0x32, 0x30,
      0x32, 0x32, 0x20,
      0x4A, 0x65, 0x72, 0x65, 0x6D, 0x79, 0x20,
      0x44, 0x61, 0x76, 0x69, 0x64, 0x20,
      0x47, 0x69, 0x65, 0x73, 0x62, 0x72, 0x65, 0x63, 0x68, 0x74, 0x20,
      0x61, 0x6E, 0x64, 0x20,
      0x74, 0x68, 0x65, 0x20,
      0x53, 0x44, 0x47, 0x53, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x70,
      0x72, 0x6F, 0x6A, 0x65, 0x63, 0x74, 0x20,
      0x63, 0x6F, 0x6E, 0x74, 0x72, 0x69, 0x62, 0x75, 0x74, 0x6F, 0x72, 0x73, 0x2E, 0x0A, 0x0A,
      0x20,
      0x53, 0x6F, 0x6C, 0x69, 0x20,
      0x44, 0x65, 0x6F, 0x20,
      0x67, 0x6C, 0x6F, 0x72, 0x69, 0x61, 0x2E, 0x0A, 0x0A, 0x20,
      0x4C, 0x69, 0x63, 0x65, 0x6E, 0x73, 0x65, 0x64, 0x20,
      0x75, 0x6E, 0x64, 0x65, 0x72, 0x20,
      0x74, 0x68, 0x65, 0x20,
      0x41, 0x70,
      0x61, 0x63, 0x68, 0x65, 0x20,
      0x4C, 0x69, 0x63, 0x65, 0x6E, 0x63, 0x65, 0x2C, 0x20,
      0x56, 0x65, 0x72, 0x73, 0x69, 0x6F, 0x6E, 0x20,
      0x32, 0x2E, 0x30,
      0x2E, 0x0A, 0x20,
      0x53, 0x65, 0x65, 0x20,
      0x68, 0x74, 0x74, 0x70,
      0x3A, 0x2F, 0x2F, 0x77, 0x77, 0x77, 0x2E, 0x61, 0x70,
      0x61, 0x63, 0x68, 0x65, 0x2E, 0x6F, 0x72, 0x67, 0x2F, 0x6C, 0x69, 0x63, 0x65, 0x6E, 0x73,
      0x65, 0x73, 0x2F, 0x4C, 0x49, 0x43, 0x45, 0x4E, 0x53, 0x45, 0x2D, 0x32, 0x2E, 0x30,
      0x20,
      0x66, 0x6F, 0x72, 0x20,
      0x6C, 0x69, 0x63, 0x65, 0x6E, 0x63, 0x65, 0x20,
      0x69, 0x6E, 0x66, 0x6F, 0x72, 0x6D, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x2E, 0x0A, 0x20,
      0x2A, 0x2F, 0x0A, 0x0A, 0x2F, 0x2A, 0x20,
      0x4C, 0x61, 0x79, 0x6F, 0x75, 0x74, 0x20,
      0x2A, 0x2F, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x64, 0x69, 0x73, 0x70,
      0x6C, 0x61, 0x79, 0x3A, 0x20,
      0x69, 0x6E, 0x6C, 0x69, 0x6E, 0x65, 0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x77, 0x68, 0x69, 0x74, 0x65, 0x2D, 0x73, 0x70,
      0x61, 0x63, 0x65, 0x3A, 0x20,
      0x70,
      0x72, 0x65, 0x2D, 0x77, 0x72, 0x61, 0x70,
      0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x2E, 0x62, 0x6C, 0x6F, 0x63,
      0x6B, 0x71, 0x75, 0x6F, 0x74, 0x65, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x64, 0x69, 0x73, 0x70,
      0x6C, 0x61, 0x79, 0x3A, 0x20,
      0x62, 0x6C, 0x6F, 0x63, 0x6B, 0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6D, 0x61, 0x72, 0x67, 0x69, 0x6E, 0x3A, 0x20,
      0x31, 0x2E, 0x36, 0x65, 0x6D, 0x20,
      0x30,
      0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x62, 0x6F, 0x72, 0x64, 0x65, 0x72, 0x3A, 0x20,
      0x31, 0x70,
      0x78, 0x20,
      0x73, 0x6F, 0x6C, 0x69, 0x64, 0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x20,
      0x62, 0x6F, 0x72, 0x64, 0x65, 0x72, 0x2D, 0x72, 0x61, 0x64, 0x69, 0x75, 0x73, 0x3A, 0x20,
      0x30,
      0x2E, 0x32, 0x33, 0x35, 0x32, 0x39, 0x65, 0x6D, 0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x70,
      0x61, 0x64, 0x64, 0x69, 0x6E, 0x67, 0x3A, 0x20,
      0x30,
      0x2E, 0x35, 0x38, 0x38, 0x32, 0x34, 0x65, 0x6D, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2F, 0x2A,
      0x20,
      0x43, 0x6F, 0x6C, 0x6F, 0x75, 0x72, 0x20,
      0x2A, 0x2F, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x2E, 0x62, 0x6C, 0x6F, 0x63,
      0x6B, 0x71, 0x75, 0x6F, 0x74, 0x65, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x62, 0x61, 0x63, 0x6B, 0x67, 0x72, 0x6F, 0x75, 0x6E, 0x64, 0x2D, 0x63, 0x6F, 0x6C, 0x6F,
      0x72, 0x3A, 0x20,
      0x23, 0x46, 0x41, 0x46, 0x41, 0x46, 0x41, 0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x62, 0x6F, 0x72, 0x64, 0x65, 0x72, 0x2D, 0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x20,
      0x23, 0x44, 0x36, 0x44, 0x36, 0x44, 0x36, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69,
      0x66, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x32, 0x36, 0x32, 0x36, 0x32, 0x36, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77,
      0x69, 0x66, 0x74, 0x20,
      0x2E, 0x6B, 0x65, 0x79, 0x77, 0x6F, 0x72, 0x64, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x41, 0x44, 0x33, 0x44, 0x41, 0x34, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77,
      0x69, 0x66, 0x74, 0x20,
      0x2E, 0x70,
      0x75, 0x6E, 0x63, 0x74, 0x75, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x32, 0x36, 0x32, 0x36, 0x32, 0x36, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77,
      0x69, 0x66, 0x74, 0x20,
      0x2E, 0x65, 0x78, 0x74, 0x65, 0x72, 0x6E, 0x61, 0x6C, 0x2E, 0x69, 0x64, 0x65, 0x6E, 0x74,
      0x69, 0x66, 0x69, 0x65, 0x72, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x38, 0x30,
      0x34, 0x46, 0x42, 0x38, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x69, 0x6E, 0x74, 0x65, 0x72, 0x6E, 0x61, 0x6C, 0x2E, 0x69, 0x64, 0x65, 0x6E, 0x74,
      0x69, 0x66, 0x69, 0x65, 0x72, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x33, 0x45, 0x38, 0x30,
      0x38, 0x37, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x6E, 0x75, 0x6D, 0x62, 0x65, 0x72, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x32, 0x43, 0x33, 0x43, 0x44, 0x38, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77,
      0x69, 0x66, 0x74, 0x20,
      0x2E, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x44, 0x31, 0x33, 0x30,
      0x32, 0x42, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67, 0xE2, 0x80,
      0x90,
      0x70,
      0x75, 0x6E, 0x63, 0x74, 0x75, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x37, 0x42, 0x32, 0x42, 0x32, 0x38, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77,
      0x69, 0x66, 0x74, 0x20,
      0x2E, 0x63, 0x6F, 0x6D, 0x70,
      0x69, 0x6C, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0xE2, 0x80,
      0x90,
      0x63, 0x6F, 0x6E, 0x64, 0x69, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x37, 0x38, 0x34, 0x39, 0x32, 0x41, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77,
      0x69, 0x66, 0x74, 0x20,
      0x2E, 0x63, 0x6F, 0x6D, 0x6D, 0x65, 0x6E, 0x74, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x37, 0x30,
      0x37, 0x46, 0x38, 0x43, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x63, 0x6F, 0x6D, 0x6D, 0x65, 0x6E, 0x74, 0xE2, 0x80,
      0x90,
      0x70,
      0x75, 0x6E, 0x63, 0x74, 0x75, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x34, 0x42, 0x35, 0x32, 0x35, 0x39, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69,
      0x66, 0x74, 0x20,
      0x2E, 0x63, 0x6F, 0x6D, 0x6D, 0x65, 0x6E, 0x74, 0xE2, 0x80,
      0x90,
      0x6B, 0x65, 0x79, 0x77, 0x6F, 0x72, 0x64, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x35, 0x43, 0x36, 0x38, 0x37, 0x34, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69,
      0x66, 0x74, 0x20,
      0x2E, 0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0xE2, 0x80,
      0x90,
      0x68, 0x65, 0x61, 0x64, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x35, 0x43, 0x36, 0x38, 0x37, 0x34, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69,
      0x66, 0x74, 0x20,
      0x2E, 0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0xE2, 0x80,
      0x90,
      0x68, 0x65, 0x61, 0x64, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x35, 0x43, 0x36, 0x38, 0x37, 0x34, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69,
      0x66, 0x74, 0x20,
      0x2E, 0x75, 0x72, 0x6C, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x32, 0x30,
      0x34, 0x36, 0x46, 0x36, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74,
      0x20,
      0x2E, 0x63, 0x6F, 0x64, 0x65, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x63, 0x6F, 0x6C, 0x6F, 0x72, 0x3A, 0x20,
      0x23, 0x32, 0x36, 0x32, 0x36, 0x32, 0x36, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2F, 0x2A, 0x20,
      0x46, 0x6F, 0x6E, 0x74, 0x20,
      0x2A, 0x2F, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x2E, 0x62, 0x6C, 0x6F, 0x63,
      0x6B, 0x71, 0x75, 0x6F, 0x74, 0x65, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x66, 0x6F, 0x6E, 0x74, 0x2D, 0x73, 0x69, 0x7A, 0x65, 0x3A, 0x20,
      0x38, 0x38, 0x2E, 0x32, 0x33, 0x35, 0x25, 0x3B, 0x0A, 0x20,
      0x20,
      0x6C, 0x69, 0x6E, 0x65, 0x2D, 0x68, 0x65, 0x69, 0x67, 0x68, 0x74, 0x3A, 0x20,
      0x31, 0x2E, 0x36, 0x36, 0x36, 0x36, 0x37, 0x3B, 0x0A, 0x20,
      0x20,
      0x6C, 0x65, 0x74, 0x74, 0x65, 0x72, 0x2D, 0x73, 0x70,
      0x61, 0x63, 0x69, 0x6E, 0x67, 0x3A, 0x20,
      0x2D, 0x30,
      0x2E, 0x30,
      0x32, 0x37, 0x65, 0x6D, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74,
      0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x6F, 0x6E, 0x74, 0x2D, 0x66, 0x61, 0x6D, 0x69, 0x6C, 0x79, 0x3A, 0x20,
      0x22, 0x53, 0x46, 0x20,
      0x4D, 0x6F, 0x6E, 0x6F, 0x22, 0x2C, 0x20,
      0x22, 0x53, 0x46, 0x20,
      0x4D, 0x6F, 0x6E, 0x6F, 0x22, 0x2C, 0x20,
      0x4D, 0x65, 0x6E, 0x6C, 0x6F, 0x2C, 0x20,
      0x6D, 0x6F, 0x6E, 0x6F, 0x73, 0x70,
      0x61, 0x63, 0x65, 0x2C, 0x20,
      0x22, 0x53, 0x46, 0x20,
      0x50,
      0x72, 0x6F, 0x20,
      0x49, 0x63, 0x6F, 0x6E, 0x73, 0x22, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69,
      0x66, 0x74, 0x20,
      0x2E, 0x74, 0x65, 0x78, 0x74, 0x2C, 0x20,
      0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0xE2, 0x80,
      0x90,
      0x68, 0x65, 0x61, 0x64, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x6F, 0x6E, 0x74, 0x2D, 0x66, 0x61, 0x6D, 0x69, 0x6C, 0x79, 0x3A, 0x20,
      0x22, 0x48, 0x65, 0x6C, 0x76, 0x65, 0x74, 0x69, 0x63, 0x61, 0x20,
      0x4E, 0x65, 0x75, 0x65, 0x22, 0x2C, 0x20,
      0x22, 0x2D, 0x61, 0x70,
      0x70,
      0x6C, 0x65, 0x2D, 0x73, 0x79, 0x73, 0x74, 0x65, 0x6D, 0x22, 0x2C, 0x20,
      0x22, 0x42, 0x6C, 0x69, 0x6E, 0x6B, 0x4D, 0x61, 0x63, 0x53, 0x79, 0x73, 0x74, 0x65, 0x6D,
      0x46, 0x6F, 0x6E, 0x74, 0x22, 0x2C, 0x20,
      0x22, 0x48, 0x65, 0x6C, 0x76, 0x65, 0x74, 0x69, 0x63, 0x61, 0x20,
      0x4E, 0x65, 0x75, 0x65, 0x22, 0x2C, 0x20,
      0x22, 0x48, 0x65, 0x6C, 0x76, 0x65, 0x74, 0x69, 0x63, 0x61, 0x22, 0x2C, 0x20,
      0x22, 0x41, 0x72, 0x69, 0x61, 0x6C, 0x22, 0x2C, 0x20,
      0x73, 0x61, 0x6E, 0x73, 0x2D, 0x73, 0x65, 0x72, 0x69, 0x66, 0x3B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x6C, 0x65, 0x74, 0x74, 0x65, 0x72, 0x2D, 0x73, 0x70,
      0x61, 0x63, 0x69, 0x6E, 0x67, 0x3A, 0x20,
      0x30,
      0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x63, 0x6F, 0x6D, 0x6D, 0x65, 0x6E, 0x74, 0xE2, 0x80,
      0x90,
      0x6B, 0x65, 0x79, 0x77, 0x6F, 0x72, 0x64, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x6F, 0x6E, 0x74, 0x2D, 0x77, 0x65, 0x69, 0x67, 0x68, 0x74, 0x3A, 0x20,
      0x62, 0x6F, 0x6C, 0x64, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x73, 0x6F, 0x75, 0x72, 0x63, 0x65, 0xE2, 0x80,
      0x90,
      0x68, 0x65, 0x61, 0x64, 0x69, 0x6E, 0x67, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x66, 0x6F, 0x6E, 0x74, 0x2D, 0x77, 0x65, 0x69, 0x67, 0x68, 0x74, 0x3A, 0x20,
      0x62, 0x6F, 0x6C, 0x64, 0x3B, 0x0A, 0x7D, 0x0A, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74,
      0x20,
      0x2E, 0x75, 0x72, 0x6C, 0x3A, 0x6C, 0x69, 0x6E, 0x6B, 0x2C, 0x20,
      0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x75, 0x72, 0x6C, 0x3A, 0x76, 0x69, 0x73, 0x69, 0x74, 0x65, 0x64, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x74, 0x65, 0x78, 0x74, 0x2D, 0x64, 0x65, 0x63, 0x6F, 0x72, 0x61, 0x74, 0x69, 0x6F, 0x6E,
      0x3A, 0x20,
      0x6E, 0x6F, 0x6E, 0x65, 0x3B, 0x0A, 0x7D, 0x0A, 0x2E, 0x73, 0x77, 0x69, 0x66, 0x74, 0x20,
      0x2E, 0x75, 0x72, 0x6C, 0x3A, 0x68, 0x6F, 0x76, 0x65, 0x72, 0x20,
      0x7B, 0x0A, 0x20,
      0x20,
      0x20,
      0x20,
      0x74, 0x65, 0x78, 0x74, 0x2D, 0x64, 0x65, 0x63, 0x6F, 0x72, 0x61, 0x74, 0x69, 0x6F, 0x6E,
      0x3A, 0x20,
      0x75, 0x6E, 0x64, 0x65, 0x72, 0x6C, 0x69, 0x6E, 0x65, 0x3B, 0x0A, 0x7D, 0x0A,
    ]
    internal static var syntaxHighlighting: String {
      return String(
        data: Data(([syntaxHighlighting0] as [[UInt8]]).lazy.joined()),
        encoding: String.Encoding.utf8
      )!
    }
  #else
    internal static var syntaxHighlighting: String {
      return String(
        data: try! Data(
          contentsOf: moduleBundle.url(forResource: "Syntax Highlighting", withExtension: "css")!,
          options: [.mappedIfSafe]
        ),
        encoding: String.Encoding.utf8
      )!
    }
  #endif
}
