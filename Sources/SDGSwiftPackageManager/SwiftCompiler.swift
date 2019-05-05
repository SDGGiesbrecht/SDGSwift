/*
 SwiftCompiler.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift

 Copyright ©2018–2019 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import Foundation

import SDGControlFlow
import SDGLogic
import SDGMathematics
import SDGLocalization

import SDGSwiftLocalizations
import SDGSwift

import PackageLoading
import Workspace

extension SwiftCompiler {

    // MARK: - Properties

    private static func hostDestination() throws -> Destination {
        return try Destination.hostDestination(AbsolutePath(location().deletingLastPathComponent().path))
    }
    internal static func hostToolchain() throws -> UserToolchain {
        return try UserToolchain(destination: hostDestination())
    }

    private static func manifestResourceProvider() throws -> ManifestResourceProvider {
        return try hostToolchain().manifestResources
    }

    internal static func manifestLoader() throws -> ManifestLoader {
        return ManifestLoader(manifestResources: try manifestResourceProvider())
    }

    // MARK: - Test Coverage

    private static func codeCoverageDirectory(for package: PackageRepository) throws -> URL {
        return try package.hostBuildParameters().codeCovPath.asURL
    }

    private static func codeCoverageDataFileName(for package: PackageRepository) throws -> String {
        return try package.manifest().name
    }

    private static func codeCoverageDataFile(for package: PackageRepository) throws -> URL {
        let directory = try codeCoverageDirectory(for: package)
        let fileName = try codeCoverageDataFileName(for: package).appending(".json")
        return directory.appendingPathComponent(fileName)
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Throws: Errors from the package manager.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public static func codeCoverageReport(
        for package: PackageRepository,
        ignoreCoveredRegions: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) throws -> TestCoverageReport? {

        let coverageDataFile = try codeCoverageDataFile(for: package)
        if ¬FileManager.default.fileExists(atPath: coverageDataFile.path) {
            return nil
        }

        let coverageData = try Data(from: coverageDataFile)
        let json = try JSONSerialization.jsonObject(with: coverageData)
        guard let coverageDataDictionary = json as? [String: Any],
            let data = coverageDataDictionary["data"] as? [Any] else {
            throw SwiftCompiler.Error.corruptTestCoverageReport
        }

        let ignoredDirectories = try package._directoriesIgnoredForTestCoverage()
        var fileReports: [FileTestCoverage] = []
        for entry in data {
            if let dictionary = entry as? [String: Any],
                let files = dictionary["files"] as? [Any] {
                for file in files {
                    if let fileDictionary = file as? [String: Any],
                        let fileName = fileDictionary["filename"] as? String {
                        let url = URL(fileURLWithPath: fileName)

                        if ¬ignoredDirectories.contains(where: { url.is(in: $0) }),
                            url.pathExtension == "swift",
                            url.lastPathComponent ≠ "LinuxMain.swift" {

                            reportProgress(String(UserFacing<StrictString, InterfaceLocalization>({ localization in
                                switch localization {
                                case .englishUnitedKingdom, .englishUnitedStates, .englishCanada:
                                    return "Parsing report for “\(url.path(relativeTo: package.location))”..."
                                }
                            }).resolved()))

                            let source = try String(from: url)
                            var regions: [CoverageRegion] = []
                            autoreleasepool {
                                if let segments = fileDictionary["segments"] as? [Any] {
                                    for (index, segment) in segments.enumerated() {
                                        if let segmentData = segment as? [Any],
                                            segmentData.count ≥ 5,
                                            let line = segmentData[0] as? Int,
                                            let column = segmentData[1] as? Int,
                                            let count = segmentData[2] as? Int,
                                            let isExectuable = segmentData[3] as? Int,
                                            isExectuable == 1 {

                                            let start = source._toIndex(line: line, column: column)
                                            let end: String.ScalarView.Index
                                            let nextIndex = segments.index(after: index)
                                            if nextIndex ≠ segments.endIndex,
                                                let nextSegmentData = segments[nextIndex] as? [Any],
                                                nextSegmentData.count ≥ 5,
                                                let nextLine = nextSegmentData[0] as? Int,
                                                let nextColumn = nextSegmentData[1] as? Int {
                                                end = source._toIndex(line: nextLine, column: nextColumn)
                                            } else {
                                                end = source.scalars.endIndex
                                            }

                                            regions.append(CoverageRegion(region: start ..< end, count: count))
                                        }
                                    }
                                }
                            }

                            CoverageRegion._normalize(
                                regions: &regions,
                                source: source,
                                ignoreCoveredRegions: ignoreCoveredRegions)
                            fileReports.append(FileTestCoverage(file: url, regions: regions))
                        }
                    }
                }
            }
        }

        return TestCoverageReport(files: fileReports)
    }
}
