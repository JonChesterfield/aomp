MODULE wave_struct_def
TYPE wavedes
        INTEGER,POINTER :: LMMAXX(:)
        END TYPE wavedes

END MODULE wave_struct_def


program test
      use wave_struct_def
      integer :: i, j, k, N
      TYPE (wavedes)  WDES
      INTEGER,POINTER :: OUTPUT(:)
      N=10

      ALLOCATE(WDES%LMMAXX(N))
      ALLOCATE(OUTPUT(N))

      do i=1, N
      WDES%LMMAXX(i) = 1
      OUTPUT(i) = 0
      enddo
      !$OMP TARGET ENTER DATA MAP(TO:WDES)
      !$OMP TARGET ENTER DATA MAP(TO:WDES%LMMAXX)

      !$OMP TARGET TEAMS DISTRIBUTE MAP(FROM:OUTPUT)
      do i=1, N
      OUTPUT(i) = WDES%LMMAXX(i)
      enddo
      !$OMP END TARGET TEAMS DISTRIBUTE

      do i=1, N
      write(*,*) "OUTPUT(", i, ")=", OUTPUT(i)
      enddo

      !$OMP TARGET EXIT DATA MAP(DELETE:WDES%LMMAXX)
      !$OMP TARGET EXIT DATA MAP(DELETE:WDES)

      end program test
