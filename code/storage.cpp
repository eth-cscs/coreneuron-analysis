struct NrnThread {
  // linked list of Memb_list (mechanisms)
  NrnThreadMembList mechanisms;
  int ncell;   // number of cells
  int nnode;   // number of nodes
  double *data;// memory pool for this cell group
  double *rhs; // VEC_RHS -> data
  double *d;   // VEC_D -> data
  double *a;   // VEC_A -> data
  double *b;   // VEC_B -> data
  double *v;   // VEC_V -> data
  int *parent_index; // indexed by p
};
// linked list for chaining 
struct NrnThreadMembList {
  struct NrnThreadMembList *next;
  struct Memb_list *mech_data; // pointer to memb_list[]
  int index;                   // index for  memb_func[]
};
union ThreadDatum {
    double val; int i;         // values
    double* pval; void* pvoid; // pointers
};
// holds the data for a mechanism
struct Memb_list { // nrnoc/nrnoc_ml.h
  // indexes of nodes with this mechanism
  // these index into matrix (i.e. VEC_*)
  int *nodeindices;
  double *data;
  ThreadDatum  *pdata;
  int nodecount;
};
// function pointer for mechanism vtable implementation
typedef void (*mod_f_t)(struct NrnThread *, Memb_list *, int);
struct Memb_func { // nrnoc/membfunc.h
  mod_f_t current;
  mod_f_t jacob;
  mod_f_t state;
}
// NrnThread::mechanisms list indexes into here [nrnoc/register_mech.c]
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
