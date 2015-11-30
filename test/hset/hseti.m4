include(seq/seq.m4)
include(hset/hset.m4)
SEQ_TEMPLATE(`seq_i', `int')dnl
HSET_TEMPLATE(`set_i', `int', `$1', `$1 == $2')dnl
#include <stddef.h>
SEQ_INTERFACE(`seq_i')
HSET_INTERFACE(`set_i')
