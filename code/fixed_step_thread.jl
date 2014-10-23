function nrn_fixed_step(cell_data::CellData)
  ### other ###
  # form the matrix (D vector and RHS)
  setup_tree_matrix_minimal(cell_data)
  # solve the linear system
  nrn_solve_minimal(cell_data)
  # update current values for I/O (not used in calculations)
  second_order_cur(cell_data)
  # advance the solution
  update(cell_data)
  ### other ###
  # update states
  nonvint(cell_data)
  ### other ###
  return None
end
