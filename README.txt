A C project template using git, gcc and GNU Make

Dependencies: git, gcc, GNU Make, bash

If you are like me, you have a myriad of small projects, and continuously
reimplement or copy the same basic makefile when setting up a new repo.
This repo is intended to be a good starting point for those projects, that can
replace the tedious setup process with a simple git pull.

Dependency checking for C source files are fully automated. The makefile
automatically selects main files for the linker, by looking for main()
functions in the source code. Just replace the dummy source and header files
with your own files, make should take care of the rest.
