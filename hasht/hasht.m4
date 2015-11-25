ifdef(`HASHT_M4',,`define(`HASHT_M4',1)dnl
include(_util/arr.m4)dnl
include(_util/append.m4)dnl
divert(-1)dnl
define(`$$hasht_err_name', `errprint(`Hash table $1 has already been defined as hasht<'_get(`HASHT_NAMES', `$1')`>.')')
define(`$$hasht_err_none', `errprint(`Hash table $1 has not been defined.')')
define(`$$hasht_err_type', `errprint(`Could not define $1 as hasht<$2, $3>.' _get(`HASHT_TYPES',`$2_$3') `is already defined as a hash table of that type.')')
define(`HASHT_TEMPLATE', `ifdef(`HASHT_NAMES[$1]', `indir(`$$hasht_err_name', `$1')',dnl
	`ifdef(`HASHT_TYPES[$2_$3]', `indir(`$$hasht_err_type', `$1', `$2', `$3')',dnl
	`	_set(`HASHT_NAMES', `$1', `$2,$3')dnl
		_set(`HASHT_NAMES_KEYS', `$1', `$2')dnl
		_set(`HASHT_NAMES_VALS', `$1', `$3')dnl
		_set(`HASHT_HFNS', `$1', `$4')dnl
		_set(`HASHT_KEY_EQ', `$1', `$5')dnl
		_set(`HASHT_TYPES', `$2_$3', `$1')dnl
		append(`$$hasht_def_names', `$1',`,')dnl This is for generic in future
		append(`$$hasht_def_keys_$2', `$1')dnl
		append(`$$hasht_kev_vals_$3', `$1')dnl
	')')dnl
')dnl
define(`HASHT_INTERFACE', `ifdef(`HASHT_NAMES[$1]', `indir(`$$hasht_iface', `$1')', `indir(`$$hasht_err_none', `$1')')')
define(`HASHT_IMPLEMENTATION', `ifdef(`HASHT_NAMES[$1]', `indir(`$$hasht_impl', `$1')', `indir(`$$hasht_err_none', `$1')')')

define(`$$hasht_iface', `define(`ACTIVE_HASHT', `$1')dnl
include(_gen/hasht/hasht.h.m4)dnl
undefine(`ACTIVE_HASHT')dnl
')dnl
define(`$$hasht_impl', `define(`ACTIVE_HASHT', `$1')dnl
include(_gen/hasht/hasht.c.m4)dnl
undefine(`ACTIVE_HASHT')dnl
')_dnl
divert dnl
')
