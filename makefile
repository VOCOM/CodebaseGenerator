# Executable name
ifdef target
TARGET = $(target)
else
TARGET = NewProject
endif

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

########## Template flags ##########
ifdef type
ifneq (,$(findstring c,$(type)))
type_override = c
else ifneq (,$(findstring python,$(type)))
type_override = py
endif
else # type
type_override = cpp
endif # type

# Overrides

# Determine project language
# C		C
# CPP	C++
# P		Python
ifneq (,$(findstring main, $(wildcard $(SOURCE_PATH)/main.*)))
ifneq (,$(findstring main.c, $(wildcard $(SOURCE_PATH)/main.c)))
MAIN_PATH 		= $(SOURCE_PATH)/main.c
COMPILER		= $(C)
else ifneq (,$(findstring main.cpp, $(wildcard $(SOURCE_PATH)/main.cpp)))
MAIN_PATH 		= $(SOURCE_PATH)/main.cpp
COMPILER		= $(CPP)
else ifneq (,$(findstring main.py, $(wildcard $(SOURCE_PATH)/main.py)))
MAIN_PATH		= $(SOURCE_PATH)/main.py
endif
else # existing_project
MAIN_PATH		= $(SOURCE_PATH)/main.$(type_override)
endif # existing_project

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
	$(info $(COMPILER))
ifneq (,$(filter $(C) $(CPP),$(COMPILER)))
	$(COMPILER) $(FLAGS) $(MAIN_PATH) -o $(BUILD_PATH)
endif

# Build Packages
package:
	$(COMPILER) $(FLAGS) -c $(MAIN_PATH) -o $(LIBRARY_PATH)/libPackage.so

########## Codebase creation section ##########
# Boiler plates
CBOILER = "int main(int argc, char** argv)\n{\n\n}"
PBOILER = 
ifeq (c,$(type_override))
BOILERPLATE = $(CBOILER)
else ifeq (cpp,$(type_override))
BOILERPLATE = $(CBOILER)
else ifeq (py,$(type_override))
BOILERPLATE = $(PBOILER)
endif

# Generate new codebase
new:
	$(shell rm -rf */)
	$(shell mkdir -p $(RELEASE_PATH) $(DEBUG_PATH) $(INCLUDE_PATH) $(LIBRARY_PATH) $(SOURCE_PATH))
	$(shell touch $(MAIN_PATH))
	$(shell echo $(BOILERPLATE) > $(MAIN_PATH))

# Clean build environment
clean:
	$(shell rm -rf $(RELEASE_PATH)/* $(DEBUG_PATH)/*)

# Reset codebase
reset:
	$(shell rm -rf */)
	$(MAKE) new