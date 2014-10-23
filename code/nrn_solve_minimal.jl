function nrn_solve_minimal(cell_group)
  ncells = cell_group.ncells
  nnodes = cell_group.nnodes
  child_nodes = ncells+1:nnodes

  # backward sweep
  for i in reverse(child_nodes)
    factor         = VEC_A[i] / VEC_D[i]
    VEC_D[p[i]]   -= factor * VEC_B[i]
    VEC_RHS[p[i]] -= factor * VEC_RHS[i]
  end

  # last step of backward sweep: apply to all root nodes
  for i in 1:ncells
    VEC_RHS[i] /= VEC_D[i];
  end

  # forward sweep
  for i in child_nodes
    VEC_RHS[i] -= VEC_B[i] * VEC_RHS[p[i]]
    VEC_RHS[i] /= VEC_D[i]
  end
end
