include(`hasht.def.m4')dnl
HASHT_DEFINITION(`hasht_si',`char *', `int', `djb2', `$1 == $2')dnl
HASHT_DEFINITION(`hasht_cc',`char *', `char *', `djb2', `!strcmp($1, $2)')dnl
HASHT_IMPLEMENTATION
