/*
 Resources.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

internal enum Resources {}
internal typealias Ressourcen = Resources

extension Resources {
  internal static let packageSwift = String(
    data: Data(
      base64Encoded:
        "Ly8gc3dpZnQtdG9vbHMtdmVyc2lvbjpbKnRvb2xzIHZlcnNpb24qXQoKaW1wb3J0IFBhY2thZ2VEZXNjcmlwdGlvbgoKbGV0IHBhY2thZ2UgPSBQYWNrYWdlKAogIG5hbWU6ICJjb25maWd1cmUiLAogIHBsYXRmb3JtczogWwogICAgLm1hY09TKC52WyptYWNPUypdKQogIF0sCiAgZGVwZW5kZW5jaWVzOiBbCiAgICAucGFja2FnZShbKnBhY2thZ2UgbmFtZSpddXJsOiAiWypVUkwqXSIsIC5leGFjdCgiWyp2ZXJzaW9uKl0iKSksCiAgICBbKnBhY2thZ2VzKl0sCiAgXSwKICB0YXJnZXRzOiBbCiAgICAudGFyZ2V0KAogICAgICBuYW1lOiAiY29uZmlndXJlIiwKICAgICAgZGVwZW5kZW5jaWVzOiBbCiAgICAgICAgWypwcm9kdWN0Kl0sCiAgICAgICAgWypwcm9kdWN0cypdLAogICAgICBdCiAgICApCiAgXQopCg=="
    )!,
    encoding: String.Encoding.utf8
  )!

}
