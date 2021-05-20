# Copyright 2003-2005,2009 Ronald S. Burkey <info@sandroid.org>
# 
# This file is part of yaAGC.
#
# yaAGC is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# yaAGC is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with yaAGC; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Filename:	Makefile
# Purpose:	Makefile for the yaYUL assembler.
# Mods:		04/11/03 RSB.	Began. 
#		10/22/03 RSB.	Added the "install" target.
#		05/14/04 RSB.	Added PREFIX.
#		04/30/05 RSB	Added CFLAGS
#		03/06/09 RSB	Added the 'all-archs' target and made 
#				various relevant adjustments.
#		2012-10-03 JL	Add YAYUL_TRACE define to turn on debug
#				messages.
#		2016-08-18 RSB	Changed the way YAYUL_TRACE works, since
#				(at least for the moment) I don't want to
#				use it, so I don't want it hard-coded into
#				CFLAGS.  It can still be used, though, just
#				invoke the make as
#					YAYUL_TRACE=-DYAYUL_TRACE make
#				(from Linux, anyway).
#		2016-08-19 RSB	Didn't do that quite right.
#		2021-05-13 MKF	Defined WASI and targets yaYUL.wasm, yaYUL.wast

ifndef PREFIX
PREFIX=/usr/local
endif

ifdef NATIVE
PREFIX_WIN=
BIN_WIN=
else
PREFIX_WIN=i386-mingw32-
PREFIX_MAC=powerpc-apple-darwin9-
BIN_WIN=${HOME}/IMCROSS/i386-mingw32/bin/
BIN_MAC=${HOME}/IMCROSS/mac/bin/
INC_MAC=${HOME}/IMCROSS/mac/include
SDK_MAC=${HOME}/IMCROSS/mac/SDKs/MacOSX10.4u.sdk
endif

ifeq ($(NATIVE),WIN32)
   EXENAME=yaYUL.exe
else
   EXENAME=yaYUL
endif

CFLAGS += ${YAYUL_TRACE}

.PHONY: default
ifdef WASI
default: $(EXENAME).wasm
else
default: $(EXENAME)
endif

ifdef WASI
WASI_SDK_PATH ?= /opt/wasi-sdk

CFLAGS2 = \
  --target=wasm32-wasi \
  --sysroot ${WASI_SDK_PATH}/share/wasi-sysroot \
  -DWASI=yes \
  -O3 \
  -flto

LDFLAGS2 = \
  --no-entry \
  --export-dynamic \
  --export=malloc \
  --export=free \
  --import-memory \
  --unresolved-symbols=import-functions \
  -L ${WASI_SDK_PATH}/share/wasi-sysroot/lib/wasm32-wasi \
  -L ${WASI_SDK_PATH}/lib/clang/12.0.0/lib/wasi \
  -lc \
  -lclang_rt.builtins-wasm32 \
  --lto-O3
endif

.PHONY: all-archs
all-archs: default yaYUL.exe yaYUL-macosx yaYUL.wasm

CFILES:=$(wildcard *.c)

yaYUL:	$(CFILES:%.c=%.o)
	${cc} ${CFLAGS} -o $@ $^ -lm

yaYUL.exe: ${CFILES}
	$(PREFIX_WIN)${cc} ${CFLAGS} -DNVER=${NVER} \
		-Wall -o $@ $^ -lm

yaYUL.wasm: $(CFILES:%.c=%.o)
	${WASI_SDK_PATH}/bin/wasm-ld ${LDFLAGS2} -o $@ $^
	wasm-opt $@ -Oz -o $@
	wasm-strip $@

yaYUL.wast: yaYUL.wasm
	wasm2wat $< > $@

yaYUL-macosx: ${CFILES}
	$(PREFIX_MAC)${cc} -arch ppc -arch i386 ${CFLAGS} -DNVER=${NVER} -Wall -o $@ $^ -lm

clean:
	-rm -f yaYUL *.o *.bc *~ *.exe *-macosx Utilities/SplitInterp Utilities/*.exe yaYUL.wasm yaYUL.wast

install: yaYUL
	cp  yaYUL ${PREFIX}/bin
	chmod ugo+x ${PREFIX}/bin/yaYUL

%.o: %.c yaYUL.h
ifdef WASI
	${WASI_SDK_PATH}/bin/clang ${CFLAGS2} -DNVER=${NVER} -c -o $@ $<
else
	${cc} ${CFLAGS} -g -O0 -DNVER=${NVER} -DINSTALLDIR=${PREFIX} -Wall -c -o $@ $<
endif
	
