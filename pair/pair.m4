ifdef(`PAIR_M4',,`define(`PAIR_M4',1)dnl
include(_util/arr.m4)dnl
divert(-1)
define(`$$pair_err_name', `errprint(`Pair $1 has already been defined as pair<'_get(`PAIR_NAMES', `$1')`>.')')
define(`$$pair_err_none', `errprint(`Pair $1 has not been defined.')')
define(`$$pair_err_type', `errprint(`Could not define $1 as pair<$2, $3>.' _get(`PAIR_TYPES',`$2_$3') `is already defined as a sequence of that type.')')

define(`PAIR_TEMPLATE', `ifdef(`PAIR_NAMES[$1]', `indir(`$$pair_err_name', `$1')', dnl
	`ifdef(`PAIR_TYPES[$2_$3]', `indir(`$$pair_err_type', `$1', `$2', `$3')', dnl
	`_set(`PAIR_NAMES', `$1', 1)dnl
	 _set(`PAIR_NAMES_T1', `$1', `$2')dnl
	 _set(`PAIR_NAMES_T2', `$1', `$3')dnl
	 _set(`PAIR_TYPES', `$2_$3', `$1')dnl
	')')dnl
')dnl

define(`PAIR_INTERFACE', `ifdef(`PAIR_NAMES[$1]', `indir(`$$pair_iface', `$1')', `indir(`$$pair_err_none', `$1')')')

define(`$$pair_iface', `define(`ACTIVE_PAIR', `$1')dnl
include(_gen/pair/pair.h.m4)dnl
undefine(`ACTIVE_PAIR')dnl
')dnl
divert dnl
')
PAIR_TEMPLATE(`p1', `char', `int')
PAIR_INTERFACE(`p1')
