/*
 CoverageRegion.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGLogic
import SDGCollections

/// A region with the same contiguous coverage status.
public struct CoverageRegion {

  // MARK: - Static Methods

  private static let charactersIrrelevantToCoverage = CharacterSet.whitespacesAndNewlines ∪ [
    "{", "}", "(", ")"
  ]

  public static func _normalize(
    regions: inout [CoverageRegion],
    source: String,
    ignoreCoveredRegions: Bool
  ) {

    // Combine to one coherent list.
    regions = regions.reduce(into: [] as [CoverageRegion]) { regions, next in
      if ignoreCoveredRegions ∧ next.count ≠ 0 {
        return  // Drop
      }

      guard var last = regions.last else {
        // First one; just append.
        regions.append(next)
        return
      }
      if last.region.upperBound > next.region.lowerBound {  // @exempt(from: tests)
        // @exempt(from: tests) False coverage result in Xocde 9.3.

        // Fix overlap.
        regions.removeLast()
        let replacement = CoverageRegion(
          region: last.region.lowerBound..<next.region.lowerBound,
          count: last.count
        )
        regions.append(replacement)
      }

      last = regions.last!
      if last.region.upperBound == next.region.lowerBound
        ∧ last.count == next.count  // @exempt(from: tests) Unreachable on Linux?
      {  // @exempt(from: tests)
        // Join contiguous regions.
        regions.removeLast()
        let replacement = CoverageRegion(
          region: last.region.lowerBound..<next.region.upperBound,
          count: last.count
        )
        regions.append(replacement)
      } else {
        // Unrelated to anything else, so just append.
        regions.append(next)
      }
    }

    // Remove false positives
    regions = regions.filter { region in

      if ¬source.scalars[region.region].contains(where: { $0 ∉ charactersIrrelevantToCoverage }) {
        // Region has no effect.
        return false
      }

      // Otherwise keep.
      return true
    }

    // Trim irrelevant characters.
    regions = regions.map { region in
      var start = region.region.lowerBound
      while source.scalars[start] ∈ charactersIrrelevantToCoverage {
        start = source.scalars.index(after: start)
      }
      var end = region.region.upperBound
      var before = source.index(before: end)
      while source.scalars[before] ∈ charactersIrrelevantToCoverage {
        end = before
        before = source.index(before: end)
      }
      return CoverageRegion(region: start..<end, count: region.count)
    }
  }

  // MARK: - Initialization

  /// Creates a coverage region.
  ///
  /// - Parameters:
  ///     - region: The region of the source code.
  ///     - count: The execution count.
  public init(region: Range<String.ScalarView.Index>, count: Int) {
    self.region = region
    self.count = count
  }

  // MARK: - Properties

  /// The region.
  public let region: Range<String.ScalarView.Index>

  /// The execution count.
  public let count: Int
}
