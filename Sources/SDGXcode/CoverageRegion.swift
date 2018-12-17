/*
 CoverageRegion.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

/// A region with the same contiguous coverage status.
public struct CoverageRegion {

    // MARK: - Properties

    /// The region.
    public let region: Range<String.ScalarView.Index>

    /// The execution count.
    public let count: Int
}
