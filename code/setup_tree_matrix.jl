function setup_tree_matrix(thread)
  nrn_rhs(thread)
  nrn_lhs(thread)
end

function nrn_rhs(thread)
  # range of non-root nodes
  child_nodes = ncells+1:nnodes

  VEC_RHS[:] = 0.

  for mechanism in thread.mechanisms
    current(mechanism)
  end

  for i in child_nodes
    dv             = VEC_V[p[i]] - VEC_V[i]
    VEC_RHS[i]    -= dv * VEC_B[i]
    VEC_RHS[p[i]] += dv * VEC_A[i]
  end
end

function nrn_lhs(thread)
  # range of non-root nodes
  child_nodes = ncells+1:nnodes

  VEC_D[:] = 0.

  for mechanism in thread.mechanisms
    jacob(mechanism)
  end

  # only for the first mechanism?
  if !isempty(thread.mechanisms)
    nrn_cap_jacob(thread.mechanisms[1]);
  end

  for i in child_nodes
    VEC_D[i]    -= VEC_B[i]
    VEC_D[p[i]] -= VEC_A[i]
  end
end
