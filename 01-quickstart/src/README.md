These instructions lead you through setup and fuzzing of a sample program.

# Get, build, and install AFL:

    $ wget https://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz
    $ tar xvf afl-latest.tgz
    $ cd afl-2.52b
    $ make
    $ sudo make install     # Optional


# The `vulnerable` program

Build our quickstart program using the instrumented compiler:

    $ ls
    afl-2.52b  quickstart
    $ cd quickstart
    $ CC=../afl-2.52b/afl-gcc AFL_HARDEN=1 make

Test it:

    $ ./vulnerable
    # Press enter to get usage instructions.
    # Test it on one of the provided inputs:
    $ ./vulnerable < inputs/u

# Fuzzing

Fuzz it:

    $ ../afl-2.52b/afl-fuzz -i inputs -o out ./vulnerable

Your session should soon resemble this: ![fuzzing session](./afl-screenshot.png)

For comparison you could also test without the provided example inputs, e.g.:

    $ mkdir in
    $ echo "my seed" > in/a
    $ ../afl-2.52b/afl-fuzz -i in -o out ./vulnerable
