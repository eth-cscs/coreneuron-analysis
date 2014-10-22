//////////////////////////////////////////////////
// in /nrnoc
//////////////////////////////////////////////////
// allocate empty storage for storing n mechanisms
void alloc_mech(int n) {
  memb_func_size_ = n;
  n_memb_func = n;
  memb_func = ecalloc(memb_func_size_, sizeof(Memb_func));
  memb_list = ecalloc(memb_func_size_, sizeof(Memb_list));
  // ...
}
// called from the .mod generated mechanism definition
// registers-
int register_mech(
        const char **m,  // strings with mech name & meta data
        mod_alloc_t alloc, mod_f_t cur, mod_f_t jacob,
        mod_f_t stat, mod_f_t initialize, ...) {
  int type; // 0 unused, 1 for cable section
  type = nrn_get_mechtype(m[1]);

  // ...
  memb_func[type].current = cur;
  memb_func[type].jacob = jacob;
  memb_func[type].state = stat;
  // ...
  memb_list[type].nodecount = 0;
  // ...
  return type;
}
//////////////////////////////////////////////////
// in mech/cfiles/
// example registering a mechanism NaTs2_t
//////////////////////////////////////////////////
static void nrn_alloc(), nrn_init(), nrn_state();
static void nrn_cur(), nrn_jacob();
static const char *_mechanism[] = {
  "6.2.0", "NaTs2_t", "gNaTs2_tbar_NaTs2_t", 0,
  "ina_NaTs2_t", "gNaTs2_t_NaTs2_t", 0,"m_NaTs2_t",
  "h_NaTs2_t", 0, 0};

_NaTs2_t_reg() {
  // ...
  register_mech(_mechanism,
    nrn_alloc, nrn_cur, nrn_jacob, nrn_state, nrn_init,
    hoc_nrnpointerindex, 1);
  // ...
}
