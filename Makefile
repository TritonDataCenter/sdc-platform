#
# Copyright (c) 2010,2011 Joyent Inc., All rights reserved.
#
CC=gcc
CFLAGS=-Wall
TARGETS=marco polo beacon sdc-sbcreate sdc-sbupload

world:  $(TARGETS)

update:
	git pull --rebase

manifest:
	cp manifest $(DESTDIR)/$(DESTNAME)

install: world
	cp -p $(TARGETS) $(DESTDIR)/smartdc/bin
	cp -p pubkey.key $(DESTDIR)/smartdc
	cp -p guest/mdata-get $(DESTDIR)/usr/sbin/mdata-get

clean:
	rm -f marco polo

sdc-sbcreate:
	touch sdc-sbcreate

sdc-sbupload:
	touch sdc-sbupload

beacon:
	touch beacon

marco: marco.c
	$(CC) $(CFLAGS) -o $@ $^ -lsocket

polo: polo.c
	$(CC) $(CFLAGS) -o $@ $^ -lsocket
	
.PHONY: manifest 
