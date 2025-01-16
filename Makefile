# Makefile  -*- mode: makefile-gmake; -*-

include config.mk

PROGRAM = $(PACKAGE_NAME)

LISPSRCS = $(shell find . -name "*.lisp")
ASDSRCS = $(wildcard *.asd)

all: $(PROGRAM)

$(PROGRAM): $(ASDSRCS) $(LISPSRCS) version config.lisp
	-rm -f $(PROGRAM)
	$(CL) $(CLFLAGS) \
	--load config.lisp \
	--eval '(asdf:load-system "$(PACKAGE_NAME)" :force t)' \
	--eval '(gc :full t)' \
	--eval '(asdf:make "$(PACKAGE_NAME)/executable")'

check:
	$(CL) $(CLFLAGS) \
	--load config.lisp \
	--eval '(asdf:test-system "$(PACKAGE_NAME)" :force t)'
clean:
	-find . -name "*.fasl" -delete
	-rm -f $(PACKAGE_NAME).info
	-rm -f $(PROGRAM)

distclean: clean
	-rm -f config.mk config.status config.lisp

install: all installdirs # install-info
	$(INSTALL_PROGRAM) $(PROGRAM) $(DESTDIR)$(bindir)/$(PROGRAM)
	$(INSTALL_DATA) README.org $(DESTDIR)$(docdir)/README.org

uninstall: uninstall-info
	-rm -f $(DESTDIR)$(bindir)/$(PROGRAM)
	-rm -f $(DESTDIR)$(docdir)/README.org

installdirs:
	$(MKDIR_P) $(DESTDIR)$(bindir)
	$(MKDIR_P) $(DESTDIR)$(docdir)
	# $(MKDIR_P) $(DESTDIR)$(infodir)

# info: $(PACKAGE_NAME).info

# $(PACKAGE_NAME).info: documentation/$(PACKAGE_NAME).texi documentation/dict.texi
# 	$(MAKEINFO) $(srcdir)/$<

# documentation/dict.texi: $(ASDSRCS) $(LISPSRCS) version config.lisp
# 	$(CL) $(CLFLAGS) \
# 	--load config.lisp \
# 	--eval '(asdf:make "$(PACKAGE_NAME)/documentation")'

# install-info: $(PACKAGE_NAME).info installdirs
# 	$(INSTALL_DATA) $< $(DESTDIR)$(infodir)/$<
# 	# run install-info if available
# 	if $(SHELL) -c 'install-info --version' \
# 	   >/dev/null 2>&1; then \
# 	   install-info --dir-file="$(DESTDIR)$(infodir)/dir" \
# 	                "$(DESTDIR)$(infodir)/$<"; \
# 	else true; fi

# uninstall-info:
# 	-rm -f $(DESTDIR)$(infodir)/$(PACKAGE_NAME).info
