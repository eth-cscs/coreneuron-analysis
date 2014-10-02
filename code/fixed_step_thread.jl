function nrn_fixed_step()
  ### other ###
  # form the matrix (d vector and RHS)
  setup_tree_matrix_minimal()
  # solve the linear system
  nrn_solve_minimal()
  # ??
  second_order_cur()
  # advance the solution 
  update(thread)
  ### other ###
  # update states
  nonvint()
  ### other ###
end
