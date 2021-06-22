prefix ?= /usr/local

build:
	:

install: bin/*
	install -D -t $(DESTDIR)$(prefix)/bin $^

uninstall: bin/*
	rm -- $(subst bin,$(DESTDIR)$(prefix)/bin,$^)

check:
	shellcheck --enable=all --severity=info bin/*

check-style:
	shellcheck --enable=all --severity=style bin/*
