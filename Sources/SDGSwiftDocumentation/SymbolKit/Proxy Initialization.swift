/*
 Proxy Initialization.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2022 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal func initialize<DecodableType, CodingProxy>(
  _ type: DecodableType.Type,
  by proxy: CodingProxy
) throws -> DecodableType where DecodableType: Decodable, CodingProxy: Encodable {
  let encoder = JSONEncoder()
  let encoded = try encoder.encode(proxy)
  let decoder = JSONDecoder()
  return try decoder.decode(DecodableType.self, from: encoded)
}
