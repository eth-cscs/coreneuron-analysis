function nrn_cap_jacob(mechanism)
  data = mechanism.data
  ni = mechanism.nodeindices

  cfac = .001 * cj
  for i in 1:mechanism.nodecount
    VEC_D[ni[i]] += cfac * data.cm[i]
  end
end
