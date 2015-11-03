dnl Int max heap
define(`HEAP_NAME', `heap_intx')dnl
define(`HEAP_DATA_TYPE', `int')dnl
define(`HEAP_COMPARE',`$1->data[$2] > $1->data[$3]')dnl
define(`HEAP_HEADER', `heap_intx.h')dnl
ifdef(`MODE_HEADER',`include(`heap.h.m4')')dnl
ifdef(`MODE_IMPL',`include(`heap.c.m4')')dnl
