#
# Makefile for NETLIB dynamic link library
#
# Bob Eager   June 2002
#
# Product name
#
PRODUCT		= netlib
#
# Target directory
#
TARGET		= f:\otherdll
#
# Compiler setup
#
CC		= icc
CFLAGS		= -G4 -Ge- -Gm -O -Q -Se
#
# Names of library files
#
LIBS =		os2386.lib
#
# Names of object files
#
OBJ =		netlib.obj
#
# Other files
#
DEF =		$(PRODUCT).def
LNK =		$(PRODUCT).lnk
#
# Final executable file and import library
#
DLL =		$(PRODUCT).dll
DLIB =		$(PRODUCT).lib
#
# Archive
#
ARCH =		arch.zip
#
#-----------------------------------------------------------------------------
#
all:		$(DLL) $(DLIB)
#
$(DLL):		$(OBJ) $(LNK) $(DEF)
		ilink /nologo /exepack:2 @$(LNK)
		lxlite $(DLL)
		eautil $(DLL) nul /s
#
$(DLIB):	$(DEF)
		implib /nologo /noignorecase $(DLIB) $(DEF)
#
# Object files
#
netlib.obj:	netlib.c
#
# Linker response file. Rebuild if makefile changes
#
$(LNK):		makefile
		@if exist $(LNK) erase $(LNK)
		@echo /map:$(PRODUCT) >> $(LNK)
		@echo /out:$(PRODUCT) >> $(LNK)
		@echo $(OBJ) >> $(LNK)
		@echo $(LIBS) >> $(LNK)
		@echo $(DEF) >> $(LNK)
#
install:	$(DLL) $(DLIB)
		@copy $(DLL) $(TARGET) > nul
#
clean:		
		-erase $(OBJ) $(LNK) $(PRODUCT).map
#
arch:		$(DLL) $(DLIB) $(DEF) *.c makefile
		zip -9 -j $(ARCH) $**
#
# End of makefile for NETLIB dynamic link library
#

