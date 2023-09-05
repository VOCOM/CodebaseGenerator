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

# Compiler flags
# -Wall 	Enable all flags
# -pthread	Enable multi-threading
# -fPIC 	Force Positional Independent Code (Dynamic Library)
CF 	= -Wall
MT 	= -pthread
PIC = -fPIC

# File path
INCLUDE_PATH 	= inc
SOURCE_PATH 	= src
LIBRARY_PATH 	= lib
RELEASE_PATH 	= build/release
DEBUG_PATH 		= build/debug

# Determine C/CPP
ifneq (,$(findstring main.c, $(wildcard $(SOURCE_PATH)/main.c)))
MAIN_PATH 		= $(SOURCE_PATH)/main.c
COMPILER		= $(C)
else ifneq (,$(findstring main.cpp, $(wildcard $(SOURCE_PATH)/main.cpp)))
MAIN_PATH 		= $(SOURCE_PATH)/main.cpp
COMPILER		= $(CPP)
endif

# Export Environment
ifdef release
FLAGS 		= $(CF) $(MT) $(PIC)
BUILD_PATH 	= $(RELEASE_PATH)/$(TARGET)
else
FLAGS 		= $(CF)
BUILD_PATH 	= $(DEBUG_PATH)/$(TARGET)
endif

# Build Target
TARGET = NewProject

# Main Target
$(TARGET):
	$(COMPILER) $(FLAGS) $(MAIN_PATH) -o $(BUILD_PATH)

# Build Packages
package:
	$(COMPILER) $(FLAGS) -c $(MAIN_PATH) -o $(LIBRARY_PATH)/libPackage.so

ifeq ($(type),c)
MAIN_PATH = $(SOURCE_PATH)/main.c
else
MAIN_PATH = $(SOURCE_PATH)/main.cpp
endif

# Build Environment
new:
	$(shell mkdir -p $(RELEASE_PATH) $(DEBUG_PATH) $(INCLUDE_PATH) $(LIBRARY_PATH) $(SOURCE_PATH))
ifeq ($(wildcard $(MAIN_PATH)),)
	$(shell echo "\nint main()\n{\n\n}" > $(MAIN_PATH))
endif

# Clean Environment
clean:
	$(shell rm -rf */)
	$(MAKE) new