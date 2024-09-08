/*
 SampleConfigurationFile.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2024 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// @example(configurationFile)
// Import the configuration definitions.
import SampleConfiguration

/*
 Exernal packages can be imported with this syntax:
 import [module] // [package name], [url], [version], [product]
 */
import SDGControlFlow
// SDGCornerstone, https://github.com/SDGGiesbrecht/SDGCornerstone, 10.0.0, SDGControlFlow

// Initialize the configuration with its defaults.
let configuration = SampleConfiguration()

// Change whatever options are available.
configuration.option = "Configured"

// The configuration loader may provide context information.
assert(SampleContext.context?.information == "Information")
// @endExample
