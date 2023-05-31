/*
 DocumentationSyntax.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2023 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

  import SDGSwiftSource

  extension DocumentationSyntax {

    func renderedSpecification(localization: String) -> String {
      var specification = ""
      if let description = descriptionSection {
        specification.append(description.renderedHTML(localization: localization))
      }
      for discussion in discussionEntries {
        specification.append(discussion.renderedHTML(localization: localization))
      }
      for parameter in normalizedParameters {
        specification.append(
          (parameter.name as ExtendedSyntax).renderedHTML(localization: localization)
        )
        for description in parameter.description {
          specification.append(description.renderedHTML(localization: localization))
        }
      }
      if let thrown = throwsCallout {
        specification.append(thrown.renderedHTML(localization: localization))
      }
      if let returnValue = returnsCallout {
        specification.append(returnValue.renderedHTML(localization: localization))
      }
      return specification
    }
  }
