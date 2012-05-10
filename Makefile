#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#
CC=gcc
CFLAGS=-Wall
TARGETS=sdc-sbcreate sdc-sbupload

world:  $(TARGETS)

update:
	git pull --rebase

manifest:
	cp manifest $(DESTDIR)/$(DESTNAME)

install: world
	cp -p $(TARGETS) $(DESTDIR)/smartdc/bin
	cp -p pubkey.key $(DESTDIR)/smartdc

clean:

sdc-sbcreate:
	touch sdc-sbcreate

sdc-sbupload:
	touch sdc-sbupload

.PHONY: manifest
