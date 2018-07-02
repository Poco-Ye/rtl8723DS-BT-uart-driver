all: rtk_hciattach

rtk_hciattach: hciattach.c hciattach_rtk.o
	cc -o rtk_hciattach hciattach.c hciattach_rtk.o

hciattach_rtk.o:hciattach_rtk.c
	cc -c hciattach_rtk.c

clean:
	rm -f *.o  rtk_hciattach tags cscope.*

tags: FORCE
	ctags -R
	find ./ -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" > cscope.files
	cscope -bkq -i cscope.files
PHONY += FORCE
FORCE:
