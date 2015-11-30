main: hset.o main.o

hset.o: hset.h

hset.c: hset.m4
	m4 -I../../ hset.m4 > $@

hset.h: hseti.m4
	m4 -I../../ hseti.m4 > $@

clean:
	-@rm main.o hset.o hset.c hset.h
