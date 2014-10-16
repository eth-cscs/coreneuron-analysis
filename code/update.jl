# in /nrnoc/eion.c
function second_order_cur(thread)
  if secondorder == 2
    for mechanism in thread.mechanisms
      if is_ion(mechanism)
        mechanism.data.c += mechanism.data.dc .* VEC_RHS
      end
    end
  end
end

# in /nrnoc/fadvance.c
function update(thread)
  factor = 1.0
  if secondorder==true
    factor = 2.0
  end
  # vectorizable
  VEC_V[:] += factor*VEC_RHS[:]
  # apply to only the first mechanism
  nrn_capacity_current(thread.mechanisms[1]);
end

# in /nrnoc/capac.c
# called by update
function nrn_capacity_current(mechanism)
  data = mechanism.nodeindices
  ni   = mechanism.data
  cfac = .001 * cj;
  for i in 1:mechanism.nodecount
    data.i_cap[i] = cfac * data.cm[i] * VEC_RHS[ni[i]]
  end
end
