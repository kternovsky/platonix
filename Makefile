CFLAGS=-std=c99 -Wall -pedantic -g

.PHONY: all clean

all: median heapsort

median: median.c heap_intn.o heap_intx.o

heapsort: heapsort.c heap_intn.o

heap_intx.h: heap_intx.m4
	m4 -DHEAP_CONFIG=heap_intx.m4 heap/heap.h.m4 > $@

heap_intx.c: heap_intx.m4 heap_intx.h
	m4 -DHEAP_CONFIG=heap_intx.m4 heap/heap.c.m4 > $@

heap_intn.h: heap_intn.m4
	m4 -DHEAP_CONFIG=heap_intn.m4 heap/heap.h.m4 > $@

heap_intn.c: heap_intn.m4 heap_intn.h
	m4 -DHEAP_CONFIG=heap_intn.m4 heap/heap.c.m4 > $@

clean:
	-@rm heap_intx.c heap_intx.h heap_intn.c heap_intn.h median *.o
