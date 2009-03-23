PROJECTNAME = GeekFace
VERSION     = 0.1

CC  = arm-apple-darwin9-gcc
CXX = arm-apple-darwin9-g++
LD  = $(CC)

#HEAVENLY=${HOME}/app/toolchain/sysroot

CFLAGS = -objc-abi-version=2 -redefined_supress -std=c99

LDFLAGS = -lobjc -bind_at_load -multiply_defined suppress
LDFLAGS += -framework CoreFoundation
LDFLAGS += -framework Foundation
LDFLAGS += -framework UIKit
LDFLAGS += -framework CoreGraphics
LDFLAGS += -framework AudioToolBox
LDFLAGS += -L${HEAVENLY}/usr/lib 
LDFLAGS += -F${HEAVENLY}/System/Library/Frameworks
LDFLAGS += -F${HEAVENLY}/System/Library/PrivateFrameworks

BUILDDIR = ./build/$(VERSION)
SRCDIR = ./src
RESDIR = ./resources

OBJS = $(patsubst %.m, %.o, $(wildcard $(SRCDIR)/*.m))
OBJS += $(patsubst %.c, %.o, $(wildcard $(SRCDIR)/*.c))
OBJS += $(patsubst %.cpp, %.o, $(wildcard $(SRCDIR)/*.cpp))

RESOURCES = $(wildcard $(RESDIR)/*)

ZIPNAME = $(PROJECTNAME)-$(VERSION).zip

$(PROJECTNAME): $(OBJS)
	$(LD) $(LDFLAGS) $(CPPFLAGS) -o $@ $^

%.o: %.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

%.o: %.cpp
	$(CXX) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

package: $(PROJECTNAME) $(RESOURCES)
	rm -rf $(BUILDDIR)
	mkdir -p $(BUILDDIR)/$(PROJECTNAME).app
	cp $(PROJECTNAME) $(BUILDDIR)/$(PROJECTNAME).app
	cp Info.plist $(BUILDDIR)/$(PROJECTNAME).app
	-cp $(RESDIR)/* $(BUILDDIR)/$(PROJECTNAME).app

dist: package $(ZIPNAME)
	find $(BUILDDIR) -type f -name .DS_Store -print0 | xargs -0 rm
	zip -r $(ZIPNAME) $(BUILDDIR)

clean:
	@rm -f $(PROJECTNAME)
	@rm -f $(SRCDIR)/*.o
	@rm -rf $(BUILDDIR)
