pushdef(`HASHT_DEF_COUNT',`0')dnl
dnl
define(`HASHT_DEFINITION',`dnl
pushdef(`HASHT_DEF_COUNT', incr(HASHT_DEF_COUNT))dnl
pushdef(`HASHT_NAME',`$1')dnl
pushdef(`HASHT_KEY_TYPE',`$2')dnl
pushdef(`HASHT_VAL_TYPE',`$3')dnl
pushdef(`HASHT_HASH',`$4')dnl
pushdef(`HASHT_KEY_CMP',`$5')dnl
ifelse(`$6', `', `pushdef(`HASHT_KEY_SEQ', `!')', `pushdef(`HASHT_KEY_SEQ',`$6')')dnl
ifelse(`$7', `', `pushdef(`HASHT_VAL_SEQ',`!')', `pushdef(`HASHT_VAL_SEQ',`$7')')dnl
')dnl
define(`HASHT_INTERFACE',`ifelse(HASHT_DEF_COUNT, `0', `',`dnl
include(hasht.h.m4)dnl
popdef(`HASHT_DEF_COUNT')dnl
popdef(`HASHT_NAME')dnl
popdef(`HASHT_KEY_TYPE')dnl
popdef(`HASHT_VAL_TYPE')dnl
popdef(`HASHT_HASH')dnl
popdef(`HASHT_KEY_CMP')dnl
popdef(`HASHT_KEY_SEQ')dnl
popdef(`HASHT_VAL_SEQ')dnl
$0
')')dnl
define(`HASHT_IMPLEMENTATION',`ifelse(HASHT_DEF_COUNT, `0', `',`dnl
include(hasht.c.m4)dnl
popdef(`HASHT_DEF_COUNT')dnl
popdef(`HASHT_NAME')dnl
popdef(`HASHT_KEY_TYPE')dnl
popdef(`HASHT_VAL_TYPE')dnl
popdef(`HASHT_HASH')dnl
popdef(`HASHT_KEY_CMP')dnl
popdef(`HASHT_KEY_SEQ')dnl
popdef(`HASHT_VAL_SEQ')dnl
$0
')')dnl
