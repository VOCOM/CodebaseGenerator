# CodebaseGenerator
 Makefile generator for small projects using cmake

How to use:\
Clone the repository and run 
```
cd build 
cmake ..
```
in the bash terminal

Commands:\
```make``` Compiles and generates executable\
```make new``` Generates new environment\
```make clean``` Cleans the build environment\
```make reset``` Clears and regenerates the codebase\
\
Attributes:\
```cversion``` Default: C17\
Set the version of the C compiler\
\
```cppversion``` Default: C20\
Set the version of the C++ Compiler\
\
```type``` Default: CPP\
Supported languages:\
C++ projects ```cpp```\
C projects ```c```\
Python projects ```p```\
\
```release``` Default: Debug\
Set the optimisation level\
Release mode ```true```\
Debug mode ```false```
