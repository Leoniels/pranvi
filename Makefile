# stlp - time lock puzzle cryptosystem
# See COPYING file for copyright and license details.
#TODO: Manual, distribution, install and uninstall

include config.mk

SRC = etlp.c dtlp.c
OBJ = $(SRC:.c=o)

all: options stlp

# Show compile options set
options:
	@echo stlp build options:
	@echo "CFLAGS  = $(CFLAGS)"
	@echo "LDFLAGS = $(LDFLAGS)"
	@echo "CC      = $(CC)"

# Compilation
.c.o:
	$(CC) -c $(CFLAGS) $<

# Linkage
etlp: etlp.o
	$(CC) -o $@ etlp.o $(LDFLAGS)

dtlp: dtlp.o
	$(CC) -o $@ dtlp.o $(LDFLAGS)

stlp: etlp dtlp

clean:
	rm -rf etlp etlp.o dtlp dtlp.o

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f etlp dtlp $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/etlp
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dtlp
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < etlp.1 > $(DESTDIR)$(MANPREFIX)/man1/etlp.1
	sed "s/VERSION/$(VERSION)/g" < dtlp.1 > $(DESTDIR)$(MANPREFIX)/man1/dtlp.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/etlp.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dtlp.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/etlp\
			$(DESTDIR)$(PREFIX)/bin/dtlp\
			$(DESTDIR)$(MANPREFIX)/man1/etlp.1
			$(DESTDIR)$(MANPREFIX)/man1/dtlp.1

.PHONY: all options clean install uninstall
