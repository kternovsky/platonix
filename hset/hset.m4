ifdef(`HSET_M4',,`define(`HSET_M4',1)dnl
include(_util/arr.m4)dnl
include(_util/append.m4)dnl
divert(-1)dnl
define(`$$hset_err_name', `errprint(`Hash table $1 has already been defined as hset<'_get(`HSET_NAMES', `$1')`>.')')
define(`$$hset_err_none', `errprint(`Hash table $1 has not been defined.')')
define(`$$hset_err_type', `errprint(`Could not define $1 as hset<$2, $3>.' _get(`HSET_TYPES',`$2') `is already defined as a hash table of that type.')')
define(`HSET_TEMPLATE', `ifdef(`HSET_NAMES[$1]', `indir(`$$hset_err_name', `$1')',dnl
	`ifdef(`HSET_TYPES[$2_$3]', `indir(`$$hset_err_type', `$1', `$2')',dnl
	`	_set(`HSET_NAMES', `$1', `$2')dnl
		_set(`HSET_NAMES_VALS', `$1', `$2')dnl
		_set(`HSET_HFNS', `$1', `$3')dnl
		_set(`HSET_KEY_EQ', `$1', `$4')dnl
		_set(`HSET_TYPES', `$2', `$1')dnl
	')')dnl
')dnl
define(`HSET_INTERFACE', `ifdef(`HSET_NAMES[$1]', `indir(`$$hset_iface', `$1')', `indir(`$$hset_err_none', `$1')')')
define(`HSET_IMPLEMENTATION', `ifdef(`HSET_NAMES[$1]', `indir(`$$hset_impl', `$1')', `indir(`$$hset_err_none', `$1')')')

define(`$$hset_iface', `define(`ACTIVE_HSET', `$1')dnl
include(_gen/hset/hset.h.m4)dnl
undefine(`ACTIVE_HSET')dnl
')dnl
define(`$$hset_impl', `define(`ACTIVE_HSET', `$1')dnl
include(_gen/hset/hset.c.m4)dnl
undefine(`ACTIVE_HSET')dnl
')_dnl
divert dnl
')
