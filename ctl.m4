include(pair/pair.m4)
include(seq/seq.m4)
include(hasht/hasht.m4)
SEQ_TEMPLATE(`seq_i', `int')dnl
SEQ_TEMPLATE(`seq_c', `char')dnl
PAIR_TEMPLATE(`pic', `int', `char')dnl
SEQ_TEMPLATE(`seq_pic', `struct pic')dnl
HASHT_TEMPLATE(`hasht_ic', `int', `char', `($1)', `$1 == $2')dnl
HASHT_TEMPLATE(`hasht_cc', `char', `char', `($1)', `$1 == $2')dnl
dnl #include <stdlib.h>
dnl SEQ_INTERFACE(`seq_i')
dnl SEQ_INTERFACE(`seq_c')
dnl PAIR_INTERFACE(`pic')
dnl SEQ_INTERFACE(`seq_pic')
dnl HASHT_INTERFACE(`hasht_ic')
dnl HASHT_IMPLEMENTATION(`hasht_ic')
indir(`$$hasht_def_names')
define(`test', `$#')
