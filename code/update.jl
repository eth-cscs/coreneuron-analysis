# in /nrnoc/eion.c
function second_order_cur(cell_group)
  if secondorder == 2
    for mechanism in cell_group.mechanisms
      if is_ion(mechanism)
        ni   = mechanism.nodeindices
        data = mechanism.data
        for i in 1:mechanism.nodecount
          data.c[i] += data.dc[i] * VEC_RHS[ni[i]]
        end
      end
    end
  end
end

# in /nrnoc/fadvance.c
function update(cell_group)
  factor = 1.0
  if secondorder==true
    factor = 2.0
  end
  # vectorizable
  VEC_V[:] += factor*VEC_RHS[:]
  # apply to only the first mechanism
  nrn_capacity_current(cell_group.mechanisms[1]);
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

