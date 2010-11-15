# Needs these vars set:
#NATIVE
#BUILD.NATIVE
#BUILD.DIST
#ANT.PROJECT.NAME
#DIST.REVISION
#GEN.INCLUDE
#JAVA.HOME

SOURCE=$(wildcard $(NATIVE)/*.c)
OBJECTS=$(subst $(NATIVE),$(BUILD.NATIVE),$(patsubst %.c,%.o,$(SOURCE)))
SHARED_OBJECT=lib$(ANT.PROJECT.NAME).so

CFLAGS=-fPIC -g
CPPFLAGS=-I $(GEN.INCLUDE) -I $(JAVA.HOME)/include/ -I $(JAVA.HOME)/include/linux/

dist: $(BUILD.DIST)/$(SHARED_OBJECT)

$(BUILD.NATIVE)/%.o: $(NATIVE)/%.c
	$(COMPILE.c) -o $@ $^

%.so: $(OBJECTS)
	gcc -shared -Wl,-soname,$(SHARED_OBJECT).$(DIST.REVISION) -lc -o $@ $<

show:
	@echo $(SOURCE)
	@echo $(OBJECTS)

