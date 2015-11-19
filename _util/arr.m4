ifdef(`ARR_M4',,`define(`ARR_M4',1)dnl
divert(-1)
define(`_set', `define(`$1[$2]', `$3')')
define(`_get', `defn(`$1[$2]')')
divert dnl
')
