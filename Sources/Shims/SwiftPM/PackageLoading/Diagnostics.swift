/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import Basic
import SPMUtility
import PackageModel

public enum PackageBuilderDiagnostics {

    /// A target in a package contains no sources.
    public struct NoSources: DiagnosticData {
        public static let id = DiagnosticID(
            type: NoSources.self,
            name: "org.swift.diags.pkg-builder.nosources",
            defaultBehavior: .warning,
            description: {
                $0 <<< "target" <<< { "'\($0.target)'" }
                $0 <<< "in package" <<< { "'\($0.package)'" }
                $0 <<< "contains no valid source files"
            }
        )

        /// The name of the package.
        public let package: String

        /// The name of the target which has no sources.
        public let target: String
    }

    /// C language test target on linux is not supported.
    public struct UnsupportedCTarget: DiagnosticData {
        public static let id = DiagnosticID(
            type: UnsupportedCTarget.self,
            name: "org.swift.diags.pkg-builder.nosources",
            defaultBehavior: .warning,
            description: {
                $0 <<< "ignoring target" <<< { "'\($0.target)'" }
                $0 <<< "in package" <<< { "'\($0.package)';" }
                $0 <<< "C language in tests is not yet supported"
            }
        )

        /// The name of the package.
        public let package: String

        /// The name of the target which has no sources.
        public let target: String
    }

    public struct DuplicateProduct: DiagnosticData {
        public static let id = DiagnosticID(
            type: DuplicateProduct.self,
            name: "org.swift.diags.pkg-builder.dup-product",
            defaultBehavior: .warning,
            description: {
                $0 <<< "Ignoring duplicate product" <<< { "'\($0.product.name)'" }
                $0 <<< .substitution({
                    let `self` = $0 as! DuplicateProduct
                    switch self.product.type {
                    case .library(.automatic):
                        return ""
                    case .executable, .test: fallthrough
                    case .library(.dynamic), .library(.static):
                         return "(\(self.product.type))"
                    }
                }, preference: .default)
            }
        )

        public let product: Product
    }

    public struct DuplicateTargetDependencyDiagnostic: DiagnosticData {
        public static let id = DiagnosticID(
            type: DuplicateTargetDependencyDiagnostic.self,
            name: "org.swift.diags.pkg-builder.dup-target-dependency",
            defaultBehavior: .warning,
            description: {
                $0 <<< "invalid duplicate target dependency declaration" <<< { "'\($0.dependency)'" }
                    <<< "in target" <<< { "'\($0.target)'" }
        })

        public let dependency: String
        public let target: String
    }

    struct SystemPackageDeprecatedDiagnostic: DiagnosticData {
        static let id = DiagnosticID(
            type: SystemPackageDeprecatedDiagnostic.self,
            name: "org.swift.diags.pkg-builder.sys-pkg-deprecated",
            defaultBehavior: .warning,
            description: {
                $0 <<< "system packages are deprecated;"
                $0 <<< "use system library targets instead"
            }
        )
    }

    struct SystemPackageDeclaresTargetsDiagnostic: DiagnosticData {
        static let id = DiagnosticID(
            type: SystemPackageDeclaresTargetsDiagnostic.self,
            name: "org.swift.diags.pkg-builder.sys-pkg-decl-targets",
            defaultBehavior: .warning,
            description: {
                $0 <<< "Ignoring declared target(s)" <<< { "'\($0.targets.joined(separator: ", "))'" } <<< "in the system package"
            }
        )

        let targets: [String]
    }

    struct SystemPackageProductValidationDiagnostic: DiagnosticData {
        static let id = DiagnosticID(
            type: SystemPackageProductValidationDiagnostic.self,
            name: "org.swift.diags.pkg-builder.sys-pkg-product-validation",
            description: {
                $0 <<< "system library product" <<< { $0.product } <<< "shouldn't have a type and contain only one target"
            }
        )

        let product: String
    }

    struct InvalidExecutableProductDecl: DiagnosticData {
        static let id = DiagnosticID(
            type: InvalidExecutableProductDecl.self,
            name: "org.swift.diags.pkg-builder.invalid-exec-product",
            description: {
                $0 <<< "executable product" <<< { "'" + $0.product + "'" } <<< "should have exactly one executable target"
            }
        )

        let product: String
    }

    struct ZeroLibraryProducts: DiagnosticData {
        static let id = DiagnosticID(
            type: ZeroLibraryProducts.self,
            name: "org.swift.diags.pkg-builder.\(ZeroLibraryProducts.self)",
            description: {
                $0 <<< "unable to synthesize a REPL product as there are no library targets in the package"
            }
        )
    }

    struct BorkenSymlinkDiagnostic: DiagnosticData {
        static let id = DiagnosticID(
            type: BorkenSymlinkDiagnostic.self,
            name: "org.swift.diags.pkg-builder.borken-symlink",
            defaultBehavior: .warning,
            description: {
                $0 <<< "ignoring broken symlink" <<< { $0.path }
            }
        )

        let path: String
    }
}

public struct ManifestLoadingDiagnostic: DiagnosticData {
    public static let id = DiagnosticID(
        type: ManifestLoadingDiagnostic.self,
        name: "org.swift.diags.pkg-loading.manifest-output",
        defaultBehavior: .warning,
        description: {
            $0 <<< { $0.output }
        }
    )

    public let output: String
}
