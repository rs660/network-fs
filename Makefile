UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
    CC := clang++
    BOOST_PREFIX := /opt/homebrew
    BOOST_THREAD := boost_thread
    CFLAGS := -D_XOPEN_SOURCE -I$(BOOST_PREFIX)/include
    LINKFLAGS := -L$(BOOST_PREFIX)/lib -l$(BOOST_THREAD)
    LIBFSCLIENT := build/libfs_client_macos.o
else
    CC := g++
    BOOST_THREAD := boost_thread
    LINKFLAGS := -l${BOOST_THREAD}
    LIBFSCLIENT := build/libfs_client.o
endif

CFLAGS += -g -Wall -std=c++20 -Wno-deprecated-declarations

# Compile a client program
testsample: testsample.cpp ${LIBFSCLIENT}
	${CC} ${CFLAGS} -o $@ $^ ${LINKFLAGS}

%: %.cpp $(LIBFSCLIENT)
	${CC} ${CFLAGS} -o $@ $^ ${LINKFLAGS}

# Generic rules for compiling a source file to an object file
%.o: %.cpp
	${CC} ${CFLAGS} -c $<

clean:
	rm -rf ${FS_OBJS} *.dSYM testsample
