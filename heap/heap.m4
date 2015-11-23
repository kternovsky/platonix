ifdef(`HEAP_M4',,`define(`HEAP_M4',1)dnl
include(_util/arr.m4)
divert(-1)
define(`$$heap_err_name', `errprint(`Pair $1 has already been defined as heap<'_get(`HEAP_NAMES', `$1')`>.')')
define(`$$heap_err_none', `errprint(`Pair $1 has not been defined.')')
define(`$$heap_err_type', `errprint(`Could not define $1 as heap<$2>.' _get(`HEAP_TYPES',`$2') `is already defined as a hash table of that type.')')
define(`HEAP_TEMPLATE', `ifdef(`HEAP_NAMES[$1]', `indir(`$$heap_err_name', `$1')', dnl
	`ifdef(`HEAP_TYPES[$2]', `indir(`$$heap_err_type', `$1', `$2')', dnl
	`	_set(`HEAP_NAMES', `$1', `$2')dnl
		_set(`HEAP_KEY_CMP', `$1', `$3')dnl
		_set(`HEAP_TYPES', `$2', `$1')dnl
	')')dnl
')dnl
define(`HEAP_INTERFACE', `ifdef(`HEAP_NAMES[$1]', `indir(`$$heap_iface', `$1')', `indir(`$$heap_err_none', `$1')')')
define(`HEAP_IMPLEMENTATION', `ifdef(`HEAP_NAMES[$1]', `indir(`$$heap_impl', `$1')', `indir(`$$heap_err_none', `$1')')')

define(`$$heap_iface', `define(`ACTIVE_HEAP', `$1')dnl
include(_gen/heap/heap.h.m4)dnl
undefine(`ACTIVE_HEAP')dnl
')dnl
define(`$$heap_impl', `define(`ACTIVE_HEAP', `$1')dnl
include(_gen/heap/heap.c.m4)dnl
undefine(`ACTIVE_HEAP')dnl
')_dnl
divert dnl
')
