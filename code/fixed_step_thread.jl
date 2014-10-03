function nrn_fixed_step(thread::NrnThread)
  ### other ###
  # form the matrix (d vector and RHS)
  setup_tree_matrix_minimal(thread)
  # solve the linear system
  nrn_solve_minimal(thread)
  # ??
  second_order_cur(thread)
  # advance the solution 
  update(thread)
  ### other ###
  # update states
  nonvint(thread)
  ### other ###
  return None
end
