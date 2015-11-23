ifdef(`SEQ_M4',,`define(`SEQ_M4', 1)
include(_util/arr.m4)dnl
divert(-1)
define(`$$seq_err_name', `errprint(`Sequence $1 is already defined as seq<'_get(`SEQ_NAMES', `$1')`>.')')
define(`$$seq_err_none', `errprint(`Sequence $1 has not been defined.')')
define(`$$seq_err_type', `errprint(`Could not define $1 as seq<$2>.' _get(`SEQ_TYPES', `$2') `is already defined as a sequence of that type.')')
define(`SEQ_TEMPLATE', `ifdef(`SEQ_NAMES[$1]', `indir(`$$seq_err_name', `$1')',dnl
	`ifdef(`SEQ_TYPES[$2]', `indir(`$$seq_err_type', `$1', `$2')', dnl
	 `_set(`SEQ_NAMES', `$1', `$2')dnl
	  _set(`SEQ_TYPES', `$2', `$1')dnl
	')')')dnl

define(`SEQ_INTERFACE', `ifdef(`SEQ_NAMES[$1]', `indir(`$$seq_iface', `$1')', `indir(`$$seq_err_none', `$1')')')

define(`$$seq_iface', `define(`ACTIVE_SEQ', `$1')dnl
include(_gen/seq/seq.h.m4)dnl
undefine(`ACTIVE_SEQ')dnl
')dnl
divert dnl
')dnl
SEQ_TEMPLATE(`seq1', `int')
SEQ_TEMPLATE(`seq2', `int')
