

// Based on https://github.com/apple/swift/blob/master/tools/SourceKit/tools/sourcekitd/include/sourcekitd/sourcekitd.h

#include <stdint.h>

typedef struct sourcekitd_uid_s *sourcekitd_uid_t;
typedef void *sourcekitd_object_t;
typedef void *sourcekitd_response_t;

typedef struct {
    uint64_t data[3];
} sourcekitd_variant_t;

void somethingToCompile();
