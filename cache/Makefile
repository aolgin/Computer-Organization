# First target is default target, if you just type:  make

FILE=hw5.c

default: a.out
	./a.out

a.out: hw5.c
	gcc -g -O0 hw5.c

debug: a.out
	gdb a.out

emacs: ${FILE}
	emacs ${FILE}
vi: ${FILE}
	vi ${FILE}

#clean:
#	rm -f hw5.c a.out *~

# 'make' will view $v as variable and try to expand it.
# By typing $$, make will reduce it to a single '$' and pass it to the shell.
# The shell will view $dir as a variable and expand it.
dist:
	dir=`basename $$PWD`; cd ..; tar cvf $$dir.tar ./$$dir; gzip $$dir.tar
	dir=`basename $$PWD`; ls -l ../$$dir.tar.gz
