function nrn_cap_jacob(thread, data)
  cfac = .001 * cj

  for i in 1:data.nodecount
    VEC_D[p[i]] += cfac * data.cm[i]
  end
end
