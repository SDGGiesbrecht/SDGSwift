/*
 XcodeSDK.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

extension Xcode {

    /// An Xcode SDK.
    public enum SDK {

        /// macOS.
        case macOS

        /// iOS.
        case iOS(simulator: Bool)

        /// watchOS.
        case watchOS

        /// tvOS.
        case tvOS(simulator: Bool)

        /// The name used by the command line interface.
        public var commandLineName: String {
            switch self {
            case .macOS:
                return "macosx"
            case .iOS(simulator: let simulator):
                if simulator {
                    return "iphonesimulator"
                } else {
                    return "iphoneos"
                }
            case .watchOS:
                return "watchos"
            case .tvOS(simulator: let simulator):
                if simulator {
                    return "appletvsimulator"
                } else {
                    return "appletvos"
                }
            }
        }
    }
}
