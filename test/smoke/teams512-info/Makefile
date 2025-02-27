#-----------------------------------------------------------------------
#
#  Makefile: Cuda clang demo Makefile for both amdgcn and nvptx targets.
#            amdgcn GPU targets begin with "gfx". nvptx targets begin
#            with sm_.  Example: To build and run on k4000 do this:
#
#            export AOMP_GPU=sm_30
#            make run
#
#  Run "make help" to see other options for this Makefile

include ../../Makefile.defs

TESTNAME = teams512-info
TESTSRC  = teams512-info.c
RUNENV   += LIBOMPTARGET_KERNEL_TRACE=1

CFLAGS = -O3 $(AOMP_CPUTARGET) -fopenmp -fopenmp-targets=$(AOMP_GPUTARGET) -Xopenmp-target=$(AOMP_GPUTARGET) -march=$(AOMP_GPU)

ifeq (sm_,$(findstring sm_,$(AOMP_GPU)))
  CUDA   ?= /usr/local/cuda
  LFLAGS += -L$(CUDA)/targets/$(UNAMEP)-linux/lib -lcudart
endif

CFLAGS += $(EXTRA_CFLAGS)

# ----- Demo compile and link in one step, no object code saved
$(TESTNAME): $(TESTSRC)
	$(CCENV) $(CC) $(CFLAGS) -DGPUINFO $(LFLAGS) $^ -o $@ -mllvm -amdgpu-dump-hsa-metadata 2>&1 | egrep '.vgpr_count|.max_flat_workgroup_size'
	$(CCENV) $(CC) $(CFLAGS) -DGPUINFO $(LFLAGS) $^ -o $@

run: $(TESTNAME)
	$(RUNENV) ./$(TESTNAME)

#  ----   Demo compile and link in two steps, object saved
$(TESTNAME).o: $(TESTSRC)
	$(CCENV) $(CC) -c $(CFLAGS) $^ -o $@

obin:	$(TESTNAME).o
	$(CCENV) $(CC) $(CFLAGS) $(LFLAGS) $^ -o $@

run_obin: obin
	$(RUNENV) ./obin

# Cleanup anything this makefile can create
clean:
	rm -f $(TESTNAME) obin *.i *.ii *.bc *.lk a.out-* *.ll *.s *.o *.cubin
