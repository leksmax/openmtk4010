
#CC=gcc

CFLAGS +=-I.
CFLAGS += -I$(ROOTDIR)/user/luci/lua-5.1.5/src
CFLAGS += -Wall -shared -fPIC
OBJ = ioctl_helper.o

all: ioctl_helper

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

ioctl_helper: $(OBJ)
	$(CC) -o $@.so $^ $(CFLAGS)

compile: ioctl_helper

install: compile
	mkdir -p $(DESTDIR)/usr/lib/lua
	cp -pR ioctl_helper.so $(DESTDIR)/usr/lib/lua/

clean:
	rm -f *.o *.so

romfs:
