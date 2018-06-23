/*
 SourceKitShims.h

 This source file is part of the SDGSwift open source project.
 https://sdggiesbrecht.github.io/SDGSwift/SDGSwift

 Copyright ©2018 Jeremy David Giesbrecht and the SDGSwift project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

// Based on https://github.com/apple/swift/blob/master/tools/SourceKit/tools/sourcekitd/include/sourcekitd/sourcekitd.h

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct sourcekitd_uid_s *sourcekitd_uid_t;
typedef void *sourcekitd_object_t;
typedef void *sourcekitd_response_t;

typedef struct {
    uint64_t data[3];
} sourcekitd_variant_t;

typedef enum {
    SOURCEKITD_VARIANT_TYPE_NULL = 0,
    SOURCEKITD_VARIANT_TYPE_DICTIONARY = 1,
    SOURCEKITD_VARIANT_TYPE_ARRAY = 2,
    SOURCEKITD_VARIANT_TYPE_INT64 = 3,
    SOURCEKITD_VARIANT_TYPE_STRING = 4,
    SOURCEKITD_VARIANT_TYPE_UID = 5,
    SOURCEKITD_VARIANT_TYPE_BOOL = 6
} sourcekitd_variant_type_t;

typedef bool (*sourcekitd_variant_dictionary_applier_f_t)(sourcekitd_uid_t key,
                                                          sourcekitd_variant_t value,
                                                          void *context);
typedef bool (*sourcekitd_variant_array_applier_f_t)(size_t index,
                                                     sourcekitd_variant_t value,
                                                     void *context);

void somethingToCompile();
