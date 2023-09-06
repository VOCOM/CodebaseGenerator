# Executable name
TARGET = NewProject

# Compiler flags
# -Wall 	Enable all flags
# -pthread	Enable multi-threading
# -fPIC 	Force Positional Independent Code (Dynamic Library)
CF 	= -Wall
MT 	= -pthread
PIC = -fPIC

# C Compiler
CCOMPILER 	= -gcc
ifdef cversion
CVERSION 	= -std=$(cversion)
else
CVERSION 	= -std=c17
endif
C			= $(CCOMPILER) $(CVERSION)

# C++ Compiler
CPPCOMPILER	= -g++
ifdef cppversion
CPPVERSION	= -std=$(cppversion)
else
CPPVERSION	= -std=c++2a
endif
CPP			= $(CPPCOMPILER) $(CPPVERSION)

# File path
INCLUDE_PATH 	= inc
SOURCE_PATH 	= src
LIBRARY_PATH 	= lib
RELEASE_PATH 	= build/release
DEBUG_PATH 		= build/debug

# Determine project language
# C		C
# CPP	C++
# P		Python
ifneq (,$(findstring main.c, $(wildcard $(SOURCE_PATH)/main.c)))
MAIN_PATH 		= $(SOURCE_PATH)/main.c
COMPILER		= $(C)
else ifneq (,$(findstring main.cpp, $(wildcard $(SOURCE_PATH)/main.cpp)))
MAIN_PATH 		= $(SOURCE_PATH)/main.cpp
COMPILER		= $(CPP)
else ifneq (,$(findstring main.py, $(wildcard $(SOURCE_PATH)/main.py)))
MAIN_PATH		= $(SOURCE_PATH)/main.py
endif

# Export Environment
ifdef release
FLAGS 		= $(CF) $(MT) $(PIC)
BUILD_PATH 	= $(RELEASE_PATH)/$(TARGET)
else
FLAGS 		= $(CF)
BUILD_PATH 	= $(DEBUG_PATH)/$(TARGET)
endif

# Main Target
$(TARGET):
ifneq (,$(filter $(C) $(CPP),$(COMPILER)))
	$(COMPILER) $(FLAGS) $(MAIN_PATH) -o $(BUILD_PATH)
endif

# Build Packages
package:
	$(COMPILER) $(FLAGS) -c $(MAIN_PATH) -o $(LIBRARY_PATH)/libPackage.so

########## Codebase creation section ##########
# Boiler plates
CINIT = "int main(int argc, char** argv)\n{\n\n}"
PINIT = 

# Type specifier override
ifeq ($(type),c)
MAIN_PATH = $(SOURCE_PATH)/main.c
else
MAIN_PATH = $(SOURCE_PATH)/main.cpp
endif

# Generate new codebase
new:
	$(shell mkdir -p $(RELEASE_PATH) $(DEBUG_PATH) $(INCLUDE_PATH) $(LIBRARY_PATH) $(SOURCE_PATH))
ifeq ($(wildcard $(MAIN_PATH)),)
	$(shell echo $(CINIT) > $(MAIN_PATH))
endif

# Clean build environment
clean:
	$(shell rm -rf $(RELEASE_PATH)/* $(DEBUG_PATH)/*)

# Reset codebase
reset:
	$(shell rm -rf */)
	$(MAKE) new