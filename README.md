# CodebaseGenerator
 Makefile generator for small projects

How to use:\
Download the makefile and run ```make new``` in the bash terminal

Commands\
```make``` Compiles and generates executable\
```make new``` Generates new environment\
```make clean``` Cleans the build environment\
```make reset``` Clears and regenerates the codebase\
\
Attributes\
```cversion``` Default: C17\
Set the version of the C compiler\
```cppversion``` Default: C20\
Set the version of the C++ Compiler\
```type``` Default: CPP\
Supported languages:\
```c```   for C projects\
```cpp``` for C++ projects\
```p```   for Python projects\
```release``` Default: ```false``` [Debug mode] \
Set true to enable multi-threading and dynamic loading
