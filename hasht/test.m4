include(`seq.def.m4')dnl
include(`hasht.def.m4')dnl
`#include' <stddef.h>
SEQ_DEFINITION(`seq_cp', `char *')dnl
SEQ_INTERFACE
HASHT_DEFINITION(`hasht_si',`char *', `int', `djb2', `$1 == $2', `struct seq_cp', `')dnl
dnl HASHT_DEFINITION(`hasht_cc',`char *', `char *', `djb2', `!strcmp($1, $2)', `seq_cp')dnl
HASHT_INTERFACE
HASHT_DEFINITION(`hasht_si',`char *', `int', `djb2', `$1 == $2', `struct seq_cp', `')dnl
HASHT_IMPLEMENTATION
