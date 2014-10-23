# definition of current for the NaTa_t mechanism
function current(mechanism::NaTaMechanism)
  data = mechanism.data
  ion  = mechanism.ion  # abstraction for ion channel
  ni   = mechansim.nodeindices

  for i in 1:mechanism.nodecount
    local v = VEC_V[ni[i]];
    data.ena[i] = ion.ena[i];
    # the v+0.001 is to take a numeric derivative
    data.g[i] = nrn_current(data, v + .001);
    local dina = data.ina[i];
    local rhs = nrn_current(data, v);

    ion.dinadv[i] += (dina - data.ina[i]) / .001;
    data.g[i] = (data.g[i] - rhs) / .001
    ion.ina[i] += data.ina[1]
    VEC_RHS[ni[i]] -= rhs;
  end
end

function nrn_current(data, v)
  data.v[i] = v;
  data.gNaTa_t[i] = data.gNaTa_tbar[i] * data.m[i] *
                    data.m[i] * data.m[i] * data.h[i]
  data.ina[i] = data.gNaTa_t[i] * (data.v[i] - data.ena[i])
  return data.ina[i];
end
