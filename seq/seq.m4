ifdef(`SEQ_M4',,`define(`SEQ_M4',1)dnl
include(_util/arr.m4)dnl
divert(-1)
pushdef(`$$seq_defs', `0')

define(`$$seq_mkdef', `dnl
	_set(`SEQ_DEFINITIONS', `$2', `$1')dnl
	pushdef(`$$seq_defs', incr(indir(`$$seq_defs')))dnl
	pushdef(`$$seq_typename', `$1')dnl
	pushdef(`$$seq_type', `$2')dnl
')dnl

define(`$$seq_pop', `dnl
	popdef(`$$seq_defs')dnl
	popdef(`$$seq_typename')dnl
	popdef(`$$seq_type')dnl
')dnl

define(`$$seq_dupdef', `errprint(`Could not create seq<$2> definition $1.', _get(`SEQ_DEFINITIONS', `$2'), `is already a seq<$2>.')')

define(`SEQ_DEFINITION', `ifdef(`SEQ_DEFINITIONS[$2]', `indir(`$$seq_dupdef', $@)', `indir(`$$seq_mkdef', `$1', `$2')')')
define(`SEQ_INTERFACE', `ifelse(indir(`$$seq_defs'), `0', `', `include(_gen/seq.h.m4) indir(`$$seq_pop') $0')')
divert dnl
')
