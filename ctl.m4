include(seq/seq.m4)
include(hasht/hasht.m4)
SEQ_TEMPLATE(`seq_i', `int')dnl
SEQ_TEMPLATE(`seq_c', `char')dnl
HASHT_TEMPLATE(`hasht_ic', `int', `char', `($1)', `$1 == $2')dnl
#include <stdlib.h>
SEQ_INTERFACE(`seq_i')
SEQ_INTERFACE(`seq_c')
HASHT_INTERFACE(`hasht_ic')
HASHT_IMPLEMENTATION(`hasht_ic')
