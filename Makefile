all:
	nasm -felf64 -g qsort.s -o qsort.o
	clang++ main.cpp -c -g -o main.o
	clang++ main.o qsort.o -o qsort
	./qsort
