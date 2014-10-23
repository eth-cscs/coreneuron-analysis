function setup_tree_matrix(cell_group)
  nrn_rhs(cell_group)
  nrn_lhs(cell_group)
end

function nrn_lhs(cell_group)
  # range of non-root nodes
  child_nodes = cell_group.ncells+1:cell_group.nnodes
  p = cell_group.parent_indices

  VEC_D[:] = 0.

  for mechanism in cell_group.mechanisms
    jacob(mechanism)
  end

  for i in child_nodes
    VEC_D[i]    -= VEC_B[i]
    VEC_D[p[i]] -= VEC_A[i]
  end
end

function nrn_rhs(cell_group)
  # range of non-root nodes
  child_nodes = cell_group.ncells+1:cell_group.nnodes
  p = cell_group.parent_indices

  # access to cell_group.VEC_* is implicit in the pseudocode
  VEC_RHS[:] = 0.

  for mechanism in cell_group.mechanisms
    current(mechanism)
  end

  for i in child_nodes
    dv             = VEC_V[p[i]] - VEC_V[i]
    VEC_RHS[i]    -= dv * VEC_B[i]
    VEC_RHS[p[i]] += dv * VEC_A[i]
  end
end
