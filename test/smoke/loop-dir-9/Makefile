include ../../Makefile.defs

TESTNAME     = loop_dir_9
TESTSRC_MAIN = loop_dir_9.c
TESTSRC_AUX  =
TESTSRC_ALL  = $(TESTSRC_MAIN) $(TESTSRC_AUX)
RUNENV      += LIBOMPTARGET_KERNEL_TRACE=1

CFLAGS       += -fopenmp-target-ignore-env-vars -fopenmp-assume-no-nested-parallelism -fopenmp-assume-no-thread-state
CLANG        = clang
OMP_BIN      = $(AOMP)/bin/$(CLANG)
CC           = $(OMP_BIN) $(VERBOSE)
#-ccc-print-phases
#"-\#\#\#"

include ../Makefile.rules
run: $(TESTNAME)
	$(RUNENV) ./$(TESTNAME) 2>&1 | $(FILECHECK) $(TESTSRC_MAIN)
