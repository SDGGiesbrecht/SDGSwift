/*
 ParametersCalloutSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A grouped “Paramaters” callout.
  public final class ParametersCalloutSyntax: CalloutSyntax {

    internal required init(
      bullet: ExtendedTokenSyntax,
      indent: ExtendedTokenSyntax,
      name: ExtendedTokenSyntax,
      space: ExtendedTokenSyntax?,
      parameterName: ExtendedTokenSyntax?,
      colon: ExtendedTokenSyntax,
      contents: [ExtendedSyntax]
    ) {

      super.init(
        bullet: bullet,
        indent: indent,
        name: name,
        space: space,
        parameterName: parameterName,
        colon: colon,
        contents: contents
      )

      for element in contents {
        if let list = element as? ListSyntax {
          for item in list.children {
            if let entry = item as? ListEntrySyntax {
              var contents = entry.contents
              for index in contents.indices {
                let component = contents[index]
                if let paragraph = component as? ParagraphSyntax,
                  let documentation = paragraph.children.first as? ExtendedTokenSyntax,
                  documentation.kind == .documentationText,
                  let colon = documentation.text.firstMatch(for: ":")
                {
                  paragraph.children.removeFirst()

                  var replacements: [ExtendedSyntax] = []
                  let parameter = ExtendedTokenSyntax(
                    text: String(documentation.text[..<colon.range.lowerBound]),
                    kind: .parameter
                  )
                  replacements.append(parameter)

                  let colonSyntax = ExtendedTokenSyntax(text: ":", kind: .colon)
                  replacements.append(colonSyntax)

                  var remainder = String(documentation.text[colon.range.upperBound...])
                  if remainder.hasPrefix(" ") {
                    remainder.removeFirst()
                    replacements.append(ExtendedTokenSyntax(text: " ", kind: .whitespace))
                  }

                  let remainderSyntax = ExtendedTokenSyntax(
                    text: remainder,
                    kind: .documentationText
                  )
                  let newParagraph = ParagraphSyntax(
                    children: paragraph.children.prepending(remainderSyntax)
                  )
                  replacements.append(newParagraph)

                  self.list.append(
                    ParameterDocumentation(
                      name: parameter,
                      description: Array(contents[contents.index(after: index)...]).prepending(
                        newParagraph
                      )
                    )
                  )

                  contents.remove(at: index)
                  contents.insert(contentsOf: replacements, at: index)

                  break
                }
              }
              entry.contents = contents
            }
          }
        }
      }
    }

    // MARK: - Parameters

    internal private(set) var list: [ParameterDocumentation] = []
  }
