#
# Copyright (c) 2010-2012 Joyent Inc., All rights reserved.
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
	@for file in $$(ls $(ROOT)/bin); do \
		/usr/sbin/install -m 0755 \
		-f $(DESTROOT)/bin \
		$(ROOT)/bin/$${file}; \
	done
	@mkdir -p $(DESTROOT)/node_modules
	for file in $$(ls $(ROOT)/node_modules); do \
		/usr/sbin/install -m 0644 \
		-f $(DESTROOT)/node_modules \
		$(ROOT)/node_modules/$${file}; \
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
	else \
		echo "Skipping manpage build, missing: $(RONNJS)"; \
	fi

.PHONY: man manifest
