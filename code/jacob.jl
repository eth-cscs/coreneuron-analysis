# the jacob function is the same for all other mechanisms
function jacob(mechanism)
  data = mechanism.data
  ni   = mechanism.nodeindices
  for i in 1:mechanism.nodecount
    VEC_D[ni[i]] += data.g[i]
  end
end

# a specialized version of jacob for the capacitance mechanism
# implemented as nrn_cap_jacob() in CoreNeuron
function jacob(mechanism::CapacitanceMechanism)
  data = mechanism.data
  ni = mechanism.nodeindices

  cfac = .001 * cj # scaling is due to unit conversion
  for i in 1:mechanism.nodecount
    VEC_D[ni[i]] += cfac * data.cm[i]
  end
end
