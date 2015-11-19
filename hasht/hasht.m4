ifdef(`HASHT_M4',,`define(`HASHT_M4',1)dnl
include(util/arr.m4)
include(seq/seq.m4)
include(pair/pair.m4)
divert(-1)
pushdef(`$$hasht_defs', `0')
define(`$$hasht_empty', `!')
define(`$$hasht_mkdef', `dnl
	_set(`HASHT_DEFINITIONS', `$2_$3', `$1')dnl
	pushdef(`$$hasht_defs', incr(indir(`$$hasht_defs')))dnl
	pushdef(`$$hasht_typename', `$1') dnl name of hash table struct
	pushdef(`$$hasht_key_type', `$2') dnl type of key used
	pushdef(`$$hasht_val_type', `$3') dnl type of value used
	pushdef(`$$hasht_hashfn', `$4') dnl how to hash keys - must be an expression, not series of statements
	pushdef(`$$hasht_key_eq', `$5') dnl how to compare keys - again, must be an expression
	pushdef(`$$hasht_key_seq', _get(SEQ_DEFINITIONS, indir(`$$hasht_key_type')))dnl
	pushdef(`$$hasht_val_seq', _get(SEQ_DEFINITIONS, indir(`$$hasht_val_type')))dnl
	pushdef(`$$hasht_kvp_seq', _get(SEQ_DEFINITIONS, _get(PAIR_DEFINITIONS, indir(`$$hasht_key_type')_`'indir(`$$hasht_val_type'))))dnl
	dnl pushdef(`$$hasht_key_seq', defn(SEQ_DEFINITIONS[indir(`$$hasht_key_type')]))dnl
	dnl pushdef(`$$hasht_val_seq', defn(SEQ_DEFINITIONS[indir(`$$hasht_val_type')]))dnl
	dnl pushdef(`$$hasht_kvp_seq', `struct 'SEQ_DEFINITIONS[PAIR_DEFINITIONS[indir(`$$hasht_key_type')_`'indir(`$$hasht_val_type')]])dnl
')dnl

define(`$$hasht_pop', `
	popdef(`$$hasht_defs')dnl
	popdef(`$$hasht_typename')dnl
	popdef(`$$hasht_key_type')dnl
	popdef(`$$hasht_val_type')dnl
	popdef(`$$hasht_hashfn')dnl
	popdef(`$$hasht_key_eq')dnl
')dnl

define(`$$hasht_dupdef', `errprint(`Could not create hasht<$2, $3> definition $1', _get(`HASHT_DEFINITIONS', `$2_$3'), `is already a hasht<$2, $3>.')')
define(`HASHT_DEFINITION', `ifdef(`HASHT_DEFINITIONS[$2_$3]', `indir(`$$hasht_dupdef', $@)', `indir(`$$hasht_mkdef', $@)')')
divert dnl
')

PAIR_DEFINITION(`pair_ii',`int',`int')
PAIR_INTERFACE
SEQ_DEFINITION(`seq_i', `int')
SEQ_INTERFACE
SEQ_DEFINITION(`seq_iip', `struct pair_ii')
SEQ_INTERFACE
HASHT_DEFINITION(`hasht_ii', `int', `int', `djb2', `$1 == $2')
dumpdef
