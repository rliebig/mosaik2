
all: bin/mosaik2 bin/mosaik2.js


bin/mosaik2: bin/tiler.o src/mosaik2.c src/mosaik2.h
	gcc -O3 src/mosaik2.c bin/tiler.o -o bin/mosaik2 -lm -lgd -lcrypto -lexif	

bin/mosaik21.o: src/mosaik21.c
	gcc -O3 -c src/mosaik21.c -o bin/mosaik21.o -lgd

bin/tiler.o: src/tiler.c bin/mosaik21.o
	gcc -O3 src/tiler.c bin/mosaik21.o -o bin/tiler.o -lm -lgd -lcrypto -lexif

bin/gathering: src/gathering.c bin/mosaik21.o
	gcc -O3 src/gathering.c bin/mosaik21.o -o bin/gathering -lm -lgd -lcrypto -lexif

bin/join: src/join.c src/mosaik21.h
	gcc -O3 src/join.c bin/mosaik21.o -o bin/join -lm -lgd -lcurl -lexif

bin/duplicates: src/duplicates.c src/mosaik21.h
	gcc -O3 src/duplicates.c bin/mosaik21.o -o bin/duplicates

bin/invalid: src/invalid.c src/mosaik21.h
	gcc -O3 src/invalid.c bin/mosaik21.o -o bin/invalid -lcrypto

bin/mosaik2.js: src/mosaik2.js
	cp src/mosaik2.js bin/mosaik2.js

clean:
	rm bin/*
