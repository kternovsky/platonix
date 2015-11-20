include(seq/seq.m4)
include(hasht/hasht.m4)
SEQ_DEFINITION(`seq_i', `int')dnl
HASHT_DEFINITION(`hasht_ii', `int', `int', `($1)', `$1 == $2')dnl
SEQ_INTERFACE
dnl HASHT_INTERFACE(`hasht_ii')
HASHT_IMPLEMENTATION(`hasht_ii')
