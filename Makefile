#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright 2015 Joyent, Inc.
#

world:
	/bin/true

update:
	git pull --rebase

manifest:
	cp manifest $(DESTDIR)/$(DESTNAME)

install: world

clean:
	/bin/true

.PHONY: manifest
