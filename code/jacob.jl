# the jacob function is specialized on mechanism type
function jacob(mechanism)
  data = mechanism.data
  ni   = mechanism.nodeindices
  for i in 1:mechanism.nodecount
    VEC_D[ni[i]] += data.g[i]
  end
end
