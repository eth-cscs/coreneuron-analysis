#TODO :  point into thread.data, with ppvar as an index
#        what is ppvar exactly?
#define _ion_ena _nt->_data[_ppvar[0]]
#define _ion_ina _nt->_data[_ppvar[1]]
#define _ion_dinadv _nt->_data[_ppvar[2]]

function current(mechanism)
  data = mechanism.data
  ni   = mechansim.nodeindices
  for i in 1:mechanism.nodecount
    _ppvar = _ml->_pdata + i * _ppsize; // TODO

    local v = VEC_V[ni[i]];
    data.ena[i] = _ion_ena; // TODO loading _p from _ppvar
    data.g[i] = nrn_current(data, v + .001);
    local dina = data.ina[i];
    local rhs = nrn_current(data, v);

    _ion_dinadv += (dina - data.ina[i]) / .001; // TODO ppvar

    data.g[i] = (data.g[i] - rhs) / .001

    _ion_ina += data.ina[1] // TODO ppvar

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
