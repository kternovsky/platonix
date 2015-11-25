dnl Ripped from autoconf
define(`append', `define(`$1', ifdef(`$1', `defn(`$1')`$3'')`$2')')
