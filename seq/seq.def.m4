pushdef(`SEQ_DEF_COUNT',`0')dnl
dnl
define(`SEQ_DEFINITION',`dnl
pushdef(`SEQ_DEF_COUNT', incr(SEQ_DEF_COUNT))dnl
pushdef(`SEQ_NAME',`$1')dnl
pushdef(`SEQ_TYPE',`$2')dnl
')dnl
define(`SEQ_INTERFACE',`ifelse(SEQ_DEF_COUNT, `0', `', `dnl
include(seq.h.m4)dnl
popdef(`SEQ_DEF_COUNT')dnl
popdef(`SEQ_NAME',`$1')dnl
popdef(`SEQ_TYPE',`$2')dnl
SEQ_INTERFACE
')')dnl
dnl For consistency:
define(`SEQ_IMPLEMENTATION',`')dnl
