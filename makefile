CC := gcc
#STRIP = strip

CFLAGS :=
LDFLAGS :=

DEBUG ?= 1
ifeq ($(DEBUG),1)
	CFLAGS += -Wall -ggdb
	LDFLAGS +=
else
	CFLAGS += -O2
	LDFLAGS +=
endif

#CFLAGS += `pkg-config --cflags gl`
#LDFLAGS += `pkg-config --libs gl`

#CFLAGS += `sdl-config --cflags`
#LDFLAGS += `sdl-config --libs`

SRCS := $(wildcard *.c)
OBJS := $(SRCS:%.c=%.o)

# targets are c files that have a make function
TGTS := $(shell grep -l -e 'main[ ]*(.*)' $(SRCS) | sed 's/\.c//g' | sort)

all: $(TGTS) .gitignore

$(TGTS): %: %.o
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $<

.PHONY: tidy clean print .gitignore

tidy:
	rm -f *~

clean: tidy
	rm -f *.{p,P,o} $(TGTS)

.gitignore:
	cp gitignore-template .gitignore
	echo $(TGTS) | sed 's/ /\n/g' >> .gitignore


print:
	@echo SRCS: $(SRCS)
	@echo OBJS: $(OBJS)
	@echo TGTS: $(TGTS)
	@echo CFLAGS: $(CFLAGS)
	@echo LDFLAGS: $(LDFLAGS)

$(TGTS:%=%.p): %.p: %.c
	$(CC) -MM $< | sed 's/\($*\).o[ :]*/\1.o \1.p: /g' > $@
	$(CC) -MM $< | sed -e 's/$*\.o[ :]*/$*: /g' -e 's/\.[ch]/\.o/g' >> $@

%.p: %.c
	$(CC) -MM $< | sed 's/\($*\).o[ :]*/\1.o \1.p: /g' > $@

include $(TGTS:%=%.p)
include $(SRCS:%.c=%.p)
