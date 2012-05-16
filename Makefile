#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#
CC=gcc
CFLAGS=-Wall
ROOT=$(PWD)
RONNJS=$(ROOT)/../../../tools/ronnjs/bin/ronn.js
DESTROOT=$(DESTDIR)/smartdc

world: man
	/bin/true

update:
	git pull --rebase

manifest:
	cp manifest $(DESTDIR)/$(DESTNAME)

install: world
	@mkdir -p $(DESTROOT)/bin
	cp -p pubkey.key $(DESTROOT)/
	@for file in $$(ls $(ROOT)/bin); do \
		/usr/sbin/install -m 0755 \
		-f $(DESTROOT)/bin \
		$(ROOT)/bin/$${file}; \
	done
	@mkdir -p $(DESTROOT)/man/man1
	for file in $$(ls $(ROOT)/man/man1/*.roff); do \
		/usr/sbin/install -m 0644 \
		-f $(DESTROOT)/man/man1 \
		$${file} ; \
		mv $(DESTROOT)/man/man1/$$(basename $${file}) \
		$(DESTROOT)/man/man1/$$(basename $${file} .roff); \
	done

clean:
	/bin/true

# Literal `date +%Y` is a fallback for uncommited .ronn file.
man:
	@if [ -x $(RONNJS) ]; then \
		for file in $$(find man -name "*.ronn"); do \
			echo $(RONNJS) --roff --build $${file} --date `git log -1 --date=short --pretty=format:'%cd' $${file}` `date +%Y`; \
			$(RONNJS) --roff --build $${file} --date `git log -1 --date=short --pretty=format:'%cd' $${file}` `date +%Y`; \
		done; \
		echo "# Run 'MANPATH=man man sdc-sbcreate' to try it out."; \
	else \
		echo "Skipping manpage build, missing: $(RONNJS)"; \
	fi

.PHONY: man manifest
