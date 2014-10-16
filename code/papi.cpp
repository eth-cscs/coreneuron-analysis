////////////////////////////////////////////////////////////
// in nrnmpi/nrmpi.c
////////////////////////////////////////////////////////////
...
#include <papi_wrap.h>

// declare handles as global variables
int pw_handle_rhs_current = -1;
int pw_handle_rhs_update = -1;
int pw_handle_nonvint = -1;
...

void nrnmpi_init(...) {
  ...
  // register handles
  pw_handle_rhs_current = pw_new_collector("rhs_current");
  pw_handle_rhs_update = pw_new_collector("rhs_update");
  pw_handle_nonvint = pw_new_collector("nonvint");
  ...
}

void nrnmpi_finalize(void) {
  // each MPI rank prints results table on cleanup
  pw_print_table();
  MPI_Finalize();
}

////////////////////////////////////////////////////////////
// in code to sample
////////////////////////////////////////////////////////////
static void nrn_rhs(NrnThread *_nt) {
    ...
  pw_start_collector(pw_handle_rhs_update);
  for (i = i1; i < i3; ++i) {
    VEC_RHS(i) = 0.;
  }
  pw_stop_collector(pw_handle_rhs_update);

  pw_start_collector(pw_handle_rhs_current);
  for (tml = _nt->tml; tml; tml = tml->next) {
    if (memb_func[tml->index].current) {
      mod_f_t s = memb_func[tml->index].current;
      (*s)(_nt, tml->ml, tml->index);
    }
  }
  pw_stop_collector(pw_handle_rhs_current);
    ...
}

