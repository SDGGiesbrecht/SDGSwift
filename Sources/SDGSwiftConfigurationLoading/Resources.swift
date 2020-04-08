/*
 Resources.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2020 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

#if !os(WASI)  // #workaround(workspace version 0.32.0, Web lacks Foundation.)
  import Foundation
#endif

internal enum Resources {}
internal typealias Ressourcen = Resources

extension Resources {
  static let package = Data(
    base64Encoded:
      "Ly8gc3dpZnQtdG9vbHMtdmVyc2lvbjo1LjAKCi8qCiBQYWNrYWdlLnN3aWZ0CgogVGhpcyBzb3VyY2UgZmlsZSBpcyBwYXJ0IG9mIHRoZSBTREdTd2lmdCBvcGVuIHNvdXJjZSBwcm9qZWN0LgogaHR0cHM6Ly9zZGdnaWVzYnJlY2h0LmdpdGh1Yi5pby9TREdTd2lmdAoKIENvcHlyaWdodCDCqTIwMTjigJMyMDIwIEplcmVteSBEYXZpZCBHaWVzYnJlY2h0IGFuZCB0aGUgU0RHU3dpZnQgcHJvamVjdCBjb250cmlidXRvcnMuCgogU29saSBEZW8gZ2xvcmlhLgoKIExpY2Vuc2VkIHVuZGVyIHRoZSBBcGFjaGUgTGljZW5jZSwgVmVyc2lvbiAyLjAuCiBTZWUgaHR0cDovL3d3dy5hcGFjaGUub3JnL2xpY2Vuc2VzL0xJQ0VOU0UtMi4wIGZvciBsaWNlbmNlIGluZm9ybWF0aW9uLgogKi8KCmltcG9ydCBQYWNrYWdlRGVzY3JpcHRpb24KCmxldCBwYWNrYWdlID0gUGFja2FnZSgKICBuYW1lOiAiY29uZmlndXJlIiwKICBwbGF0Zm9ybXM6IFsKICAgIC5tYWNPUygudlsqbWFjT1MqXSkKICBdLAogIGRlcGVuZGVuY2llczogWwogICAgLnBhY2thZ2UodXJsOiAiWypVUkwqXSIsIC5leGFjdCgiWyp2ZXJzaW9uKl0iKSksCiAgICBbKnBhY2thZ2VzKl0sCiAgXSwKICB0YXJnZXRzOiBbCiAgICAudGFyZ2V0KAogICAgICBuYW1lOiAiY29uZmlndXJlIiwKICAgICAgZGVwZW5kZW5jaWVzOiBbCiAgICAgICAgIlsqcHJvZHVjdCpdIiwKICAgICAgICBbKnByb2R1Y3RzKl0sCiAgICAgIF0KICAgICkKICBdCikK"
  )!

}
