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
import SDGText
import SDGLocalization

import SDGSwiftLocalizations
import SDGSwift

import PackageLoading
import Workspace

extension SwiftCompiler {

    // MARK: - Properties

    private static func hostDestination() -> Swift.Result<Destination, HostDestinationError> {
        switch location() {
        case .failure(let error):
            return .failure(.swiftLocationError(error))
        case .success(let location):
            let destination: Destination
            do {
                destination = try Destination.hostDestination(AbsolutePath(location.deletingLastPathComponent().path))
            } catch {
                return .failure(.packageManagerError(error))
            }
            return .success(destination)
        }
    }
    internal static func hostToolchain() -> Swift.Result<UserToolchain, HostDestinationError> {
        switch hostDestination() {
        case .failure(let error):
            return .failure(error)
        case .success(let destination):
            let toolchain: UserToolchain
            do {
                toolchain = try UserToolchain(destination: destination)
            } catch {
                return .failure(.packageManagerError(error))
            }
            return .success(toolchain)
        }
    }

    private static func manifestResourceProvider() -> Swift.Result<ManifestResourceProvider, HostDestinationError> {
        return hostToolchain().map { $0.manifestResources }
    }

    internal static func manifestLoader() -> Swift.Result<ManifestLoader, HostDestinationError> {
        return manifestResourceProvider().map { ManifestLoader(manifestResources: $0) }
    }

    // MARK: - Test Coverage

    private static func codeCoverageDirectory(for package: PackageRepository) -> Swift.Result<Foundation.URL, SwiftCompiler.HostDestinationError> {
        return package.hostBuildParameters().map { $0.codeCovPath.asURL }
    }

    private static func codeCoverageDataFileName(for package: PackageRepository) -> Swift.Result<String, SwiftCompiler.HostDestinationError> {
        return package.manifest().map { $0.name }
    }

    private static func codeCoverageDataFile(for package: PackageRepository) -> Swift.Result<Foundation.URL, SwiftCompiler.HostDestinationError> {
        switch codeCoverageDirectory(for: package) {
        case .failure(let error):
            return .failure(error)
        case .success(let directory):
            switch codeCoverageDataFileName(for: package) {
            case .failure(let error):
                return .failure(error)
            case .success(let fileName):
                return .success(directory.appendingPathComponent(fileName.appending(".json")))
            }
        }
    }

    /// Returns the code coverage report for the package.
    ///
    /// - Parameters:
    ///     - package: The package to test.
    ///     - ignoreCoveredRegions: Optional. Set to `true` if only coverage gaps are significant. When `true`, covered regions will be left out of the report, resulting in faster parsing.
    ///     - reportProgress: Optional. A closure to execute for each line of output.
    ///     - progressReport: A line of output.
    ///
    /// - Returns: The report, or `nil` if there is no code coverage information.
    public static func codeCoverageReport(
        for package: PackageRepository,
        ignoreCoveredRegions: Bool = false,
        reportProgress: (_ progressReport: String) -> Void = SwiftCompiler._ignoreProgress) -> Swift.Result<TestCoverageReport?, CoverageReportingError> {

        let coverageDataFile: Foundation.URL
        switch codeCoverageDataFile(for: package) {
        case .failure(let error):
            return .failure(.hostDestinationError(error))
        case .success(let file):
            coverageDataFile = file
        }
        if ¬FileManager.default.fileExists(atPath: coverageDataFile.path) {
            return .success(nil)
        }

        let json: Any
        do {
            let coverageData = try Data(from: coverageDataFile)
            json = try JSONSerialization.jsonObject(with: coverageData)
        } catch {
            return .failure(.foundationError(error))
        }
        guard let coverageDataDictionary = json as? [String: Any],
            let data = coverageDataDictionary["data"] as? [Any] else {
                return .failure(.corruptTestCoverageReport) // @exempt(from: tests) Unreachable without mismatched Swift version.
        }

        let ignoredDirectories: [Foundation.URL]
        switch package._directoriesIgnoredForTestCoverage() {
        case .failure(let error):
            return .failure(.hostDestinationError(error))
        case .success(let directories):
            ignoredDirectories = directories
        }
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

                            let source: String
                            do {
                                source = try String(from: url)
                            } catch {
                                return .failure(.foundationError(error))
                            }
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
                                                end = source.scalars.endIndex // @exempt(from: tests) Can a test region even be at the very end of a file?
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

        return .success(TestCoverageReport(files: fileReports))
    }
}
