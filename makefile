# Compiler
CCOMPILER 	= -g++
ifdef version
CPPVERSION 	= -std=$(version)
else
CPPVERSION 	= -std=c++2a
endif
CC = $(CCOMPILER) $(CPPVERSION)

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
MAIN_PATH 		= $(SOURCE_PATH)/main.cpp

# Export Environment
ifdef RELEASE
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
	$(CC) $(FLAGS) $(MAIN_PATH) -o $(BUILD_PATH)

# Build Packages
package:
	$(CC) $(FLAGS) -c $(MAIN_PATH) -o $(LIBRARY_PATH)/libPackage.so

# Build Environment
new:
	$(shell mkdir -p $(RELEASE_PATH) $(DEBUG_PATH) $(INCLUDE_PATH) $(LIBRARY_PATH) $(SOURCE_PATH))
ifeq ($(wildcard $(MAIN_PATH)),)
	$(shell echo "\nint main()\n{\n\n}" > $(MAIN_PATH))
endif