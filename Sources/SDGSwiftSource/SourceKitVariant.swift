/*
 SourceKitVariant.swift

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGLogic

import SDGSourceKitShims

extension SourceKit {

    internal enum Variant {

        // MARK: - Cases

        case dictionary([String: Variant])
        case array([Variant])
        case integer(Int)
        case string(String)
        case boolean(Bool)

        // MARK: - Initialization

        internal init?(_ rawValue: sourcekitd_variant_t) throws {
            let type = (try SourceKit.load(symbol: "sourcekitd_variant_get_type") as (@convention(c) (sourcekitd_variant_t) -> sourcekitd_variant_type_t))(rawValue)
            switch type {
            case SOURCEKITD_VARIANT_TYPE_NULL:
                return nil
            case SOURCEKITD_VARIANT_TYPE_DICTIONARY:
                typealias Context = (dictionary: [String: Variant], error: Swift.Error?)
                var context: Context = (dictionary: [:], error: nil)
                let iterator: sourcekitd_variant_dictionary_applier_f_t = { key, value, contextPointer in
                    let context = contextPointer!.assumingMemoryBound(to: Context.self)
                    do {
                        let uid = UID(key!)
                        let value = try Variant(value)
                        context.pointee.dictionary[try uid.string()] = value
                        return true
                    } catch let thrown {
                        context.pointee.error = thrown
                        return false
                    }
                }
                let apply = (try SourceKit.load(symbol: "sourcekitd_variant_dictionary_apply_f") as (@convention(c) (sourcekitd_variant_t, @escaping sourcekitd_variant_dictionary_applier_f_t, UnsafeMutableRawPointer?) -> Bool))

                let succeeded = withUnsafeMutablePointer(to: &context) { contextPointer in
                    return apply(rawValue, iterator, contextPointer)
                }
                if ¬succeeded {
                    throw context.error!
                }
                self = .dictionary(context.dictionary)
            case SOURCEKITD_VARIANT_TYPE_ARRAY:
                typealias Context = (array: [Variant], error: Swift.Error?)
                var context: Context = (array: [], error: nil)
                let iterator: sourcekitd_variant_array_applier_f_t = { _, value, contextPointer in
                    let context = contextPointer!.assumingMemoryBound(to: Context.self)
                    do {
                        if let value = try Variant(value) {
                            context.pointee.array.append(value)
                        }
                        return true
                    } catch let thrown {
                        context.pointee.error = thrown
                        return false
                    }
                }
                let apply = (try SourceKit.load(symbol: "sourcekitd_variant_array_apply_f") as (@convention(c) (sourcekitd_variant_t, @escaping sourcekitd_variant_array_applier_f_t, UnsafeMutableRawPointer?) -> Bool))

                let succeeded = withUnsafeMutablePointer(to: &context) { contextPointer in
                    return apply(rawValue, iterator, contextPointer)
                }
                if ¬succeeded {
                    throw context.error!
                }
                self = .array(context.array)
            case SOURCEKITD_VARIANT_TYPE_INT64:
                let integer = (try SourceKit.load(symbol: "sourcekitd_variant_int64_get_value") as (@convention(c) (sourcekitd_variant_t) -> Int64))(rawValue)
                self = .integer(Int(integer))
            case SOURCEKITD_VARIANT_TYPE_STRING:
                let string = (try SourceKit.load(symbol: "sourcekitd_variant_string_get_ptr") as (@convention(c) (sourcekitd_variant_t) -> UnsafePointer<Int8>?))(rawValue)
                self = .string(String(cString: string!))
            case SOURCEKITD_VARIANT_TYPE_UID:
                let uid = (try SourceKit.load(symbol: "sourcekitd_variant_uid_get_value") as (@convention(c) (sourcekitd_variant_t) -> sourcekitd_uid_t?))(rawValue)
                self = .string(try UID(uid!).string())
            case SOURCEKITD_VARIANT_TYPE_BOOL:
                let boolean = (try SourceKit.load(symbol: "sourcekitd_variant_bool_get_value") as (@convention(c) (sourcekitd_variant_t) -> Bool))(rawValue)
                self = .boolean(boolean)
            default:
                throw SourceKit.Error.unknownTypeVariant(identifier: Int(type.rawValue))
            }
        }

        internal func asAny() -> Any {
            switch self {
            case .dictionary(let dictionary):
                var result: [String: Any] = [:]
                for (key, value) in dictionary {
                    result[key] = value.asAny()
                }
                return result
            case .array(let array):
                return array.map { $0.asAny() }
            case .integer(let integer):
                return integer
            case .string(let string):
                return string
            case .boolean(let boolean):
                return boolean
            }
        }
    }
}
