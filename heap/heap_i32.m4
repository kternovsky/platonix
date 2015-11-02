define(`HEAP_NAME', `heap_i32')dnl
define(`HEAP_DATA_TYPE', `int32_t')dnl
define(`HEAP_COMPARE',`$1->data[$2] > $1->data[$3]')dnl
define(`HEAP_HEADER', `heap_i32.h')dnl
define(`HEAP_PREAMBLE', `#include <stdint.h>')dnl
