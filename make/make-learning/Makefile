# all: clean build

all: clean test

clean:
	rm -f test *.o

# build:
# 	gcc test.c -o test

test.o:
	gcc test.c -c -o test.o

test: test.o
	gcc test.o -o test
