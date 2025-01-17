# ntvao
NT Virtual Apple One. Apple 1 emulator for Windows, MacOS, Linux, and real-mode 8086 DOS.

This app (like many others!) emulates an Apple 1. To invoke it in that mode, run ntvao with no arguments.

Linux and MacOS vs. Windows:

    * 40x24 mode only works on Windows; on Linux and MacOS the whole terminal window is used. 
    * The emulator runs about 20% faster on Linux and MacOS because the Gnu C++ compiler generates more
      efficient code than the Microsoft compiler. (But you can build with the Gnu compiler on Windows to
      get the performance there too.)
    * with Visual Studio 2022, the emulator can be compiled with 
        cl.exe ntvao.cxx mos6502.cxx /I. /DNDEBUG user32.lib
        (no Watcom conditional compiles, the resulting exe must be launched in Windows XP compatibility mode
        for better results)

Usage:

    usage: ntvao [-a] [-c] [-i] [-p] [-s:X] [-t] [-u] [.hex file>]
      arguments:
         -a     address at which the run is started, e.g. /a:0x1000
                this overrides the default, which is 0xff00 or the first address in the input file.
         -c     don't set the console to 40x24. do exit ntvao when the Apple 1 app completes.
         -h     don't automatically install the Apple 1 monitor and BASIC; use hook emulation instead.
         -i     when tracing is enabled with -t, also show each instruction executed.
         -p     show performance information at app exit.
         -s:X   speed in Hz. Default is as fast as possible.
                for the Apple 1's speed use -s:1022727
         -t     enable debug tracing to ntvao.log
         -u     disable converting output chars to uppercase.
      notes:
         --     to assemble, load, and run test.s:
                    sbasm30306\sbasm.py test.s
                    ntvao -c test.hex
         --     .hex files can be in Apple 1 format or Intel hex format.
         --     any 6502 app will run but with no OS support it can be hard to tell.
         --     when using -c, ntvao will exit when the app calls 0xff1f instead of starting the monitor
         --     control keys:
                    ^c        gracefully exit ntvao
                    ^d        save a 64k memory dump in ntvao.dmp
                    ^l        load a file into the keyboard input stream. This is
                              likely an Apple 1 format .hex for monitor or .bas for BASIC
                    ^q        quit ntvao at the next app keyboard read
                    ^r        soft reset via the 6502's 0xfffc reset vector
                    ^break    forcibly exit the app
  
file descriptions:

    apple1.hex:       the Apple 1 Monitor and BASIC code. Found all over the web; I didn't author this.
    wozmon.hex:       just the Apple 1 Monitor without BASIC. Found all over the web; I didn't author this.
    ntvao.cxx:        loads the 6502 emulator and drives the app
    mos6502.cxx:      the 6502 emulator with a few additions to enable Apple 1 emulation
    m.bat:            builds ntvao.exe using a Visual Studio vcvars64.bat environment. mr.bat for release.
    mg.bat            builds using mingw64 g++. mgr.bat for release.
    m.sh:             builds ntvao on Linux. mr.sh for release.
    mwatcom.bat:      builds ntvao on Windows targeting real-mode 8086 DOS using the Watcom compiler.
    6502_functional_test.hex: test suite for the 6502 from Klaus Dormann: https://github.com/Klaus2m5/6502_65C02_functional_tests
    run_fun_test.bat: invokes ntvao with the test suite for validation
    ttta1.bas:        Apple 1 BASIC app to prove you can't win a Nuclear War per War Games
    hello.s:          simple hello world test app
    hello.hex:        code for hello.s

notes:
    
    I wrote this so I could test the output of my BA BASIC compiler (in my TTT repo) in an automated
    way from a Windows command prompt. I use the -c switch in ntvao so it doesn't change the window to 
    40x24 when running and so it terminates when the Apple 1 app terminates.
    
    The 6502 emulator was tested with the Klaus Dormann suite (6502_functional_test.hex), a few 
    stand-alone programs, a bunch of test apps generated by the BA compiler, and the real Apple 1 
    Monitor and BASIC code with some BASIC apps. I also validated that a suite of test apps written
    in C and compiled with the Aztec and cc65 C compilers work.
    
    apple1.hex is an example of putting two separate apps in one .hex file. This can be done with the 
    Monitor and any other app.
    
    When the Monitor isn't installed, its functions and keyboard memory side-effects are emulated. So 
    Apple 1 apps will work regardless of whether the real Monitor is installed. Use -h to get this.
    
    Tracing with -t -i to ntvao.log disassembles code as it runs, so you can see how things work, or 
    don't work.

    Built and tested on Windows on x86, AMD64, and Arm64. Also Linux on Arm32, Arm64, and AMD64. Also on MacOS on an M1.
    
    The name is from ntvdm -- the Windows NT Virtual DOS Machine.

    The -p switch shows runtime information. In this example, the app took 21 seconds to run, 
    but on a real Apple 1 it would have taken three and a half hours.
    
    elapsed milliseconds:           20,556
    6502 cycles:            12,637,173,761
    clock rate:                  unbounded
    ms at 1.022727 Mhz:         12,356,350 == 0 days, 3 hours, 25 minutes, 56 seconds, 350 milliseconds
 
