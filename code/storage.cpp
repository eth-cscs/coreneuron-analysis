struct NrnThread {
  // linked list of Memb_list (mechanisms)
  NrnThreadMembList mechanisms;

  int ncell;     // number of cells
  int nnode;     // number of nodes
  double *data;  // what is this data? Pramod?

  double *rhs; // indexed by VEC_RHS
  double *d;   // indexed by VEC_D
  double *a;   // indexed by VEC_A
  double *b;   // indexed by VEC_B
  double *v;   // indexed by VEC_V
  int *parent_index; // indexed by p
};

// linked list for chaining 
struct NrnThreadMembList {
  struct NrnThreadMembList *next;
  struct Memb_list *mech_data; // pointer to memb_list[]
  int index;                   // index for  memb_func[]
};

// holds the data for a mechanism
struct Memb_list { // nrnoc/nrnoc_ml.h
  // indexes of nodes with this mechanism
  // these index into matrix (i.e. VEC_*)
  int *nodeindices;
  double *data;
  int nodecount;
};

// function pointer for mechanism vtable implementation
typedef void (*mod_f_t)(struct NrnThread *, Memb_list *, int);
struct Memb_func { // nrnoc/membfunc.h
  mod_f_t current;
  mod_f_t jacob;
  mod_f_t state;
}

// NrnThread::mechanisms list indexes into here
// declared in nrnoc/register_mech.c
Memb_func* memb_func = malloc(memb_func_size*sizeof(Memb_func));
Memb_list* memb_list = malloc(memb_func_size*sizeof(Memb_list));

// example loop
NrnThreadMembList* mech;
for (mech = &thread->mechanisms; mech!=nullptr; mech = mech->next) {
  if (memb_func[mech->index].jacob) {
    mod_f_t s = memb_func[mech->index].jacob;
    (*s)(thread, mech->mech_data, mech->index);
  }
}
