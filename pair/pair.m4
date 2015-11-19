ifdef(`PAIR_M4',,`define(`PAIR_M4',1)dnl
include(_util/arr.m4)dnl
divert(-1)
pushdef(`$$pair_defs', `0')

define(`$$pair_mkdef', `dnl
	_set(`PAIR_DEFINITIONS', `$2_$3', `$1')dnl
	pushdef(`$$pair_defs', incr(indir(`$$pair_defs'))) dnl
	pushdef(`$$pair_typename', `$1') dnl
	pushdef(`$$pair_first', `$2') dnl
	pushdef(`$$pair_second', `$3')dnl
')dnl
define(`$$pair_pop', `dnl
	popdef(`$$pair_defs') dnl
	popdef(`$$pair_typename') dnl
	popdef(`$$pair_first') dnl
	popdef(`$$pair_second')dnl
')dnl

define(`$$pair_dupdef', `errprint(`Could not create pair<$2, $3> definition $1.', _get(`PAIR_DEFINITIONS', `$2_$3'), `is already a pair<$2, $3>.')')

define(`PAIR_DEFINITION', `ifdef(`PAIR_DEFINITIONS[$2_$3]', `indir(`$$pair_dupdef', $@)', `indir(`$$pair_mkdef', `$1', `$2', `$3')')')
define(`PAIR_INTERFACE', `include(_gen/pair/pair.h.m4) indir(`$$pair_pop')')dnl
divert dnl
')
