CFLAGS=-std=c99 -Wall -pedantic -g

.PHONY: all clean examples

.PRECOUS: examples/hasht_ii.c

vpath %.m4 hasht:heap

examples: examples/median examples/heapsort examples/counter examples/rehash

examples/median: examples/median.c examples/heap_intn.o examples/heap_intx.o | examples/heap_intx.h

examples/heapsort: examples/heapsort.c examples/heap_intn.o | examples/heap_intn.h

examples/counter: examples/counter.c examples/hasht_ii.o | examples/hasht_ii.h

examples/rehash: examples/rehash.c examples/hasht_ii.o | examples/hasht_ii.h

examples/hasht_%.h: examples/hasht_%.m4 hasht.h.m4
	m4 -Ihasht -DMODE_HEADER $< >$@

examples/hasht_%.c: examples/hasht_%.m4 examples/hasht_%.h hasht.c.m4
	m4 -Ihasht -DMODE_IMPL $< >$@

examples/heap_%.h: examples/heap_%.m4 heap.h.m4
	m4 -Iheap -DMODE_HEADER $< >$@

examples/heap_%.c: examples/heap_%.m4 examples/heap_%.h heap.c.m4
	m4 -Iheap -DMODE_IMPL $< >$@
