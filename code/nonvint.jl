function nonvint(cell_group)
  for mechanism in cell_group.mechanisms
    state(mechanism)
  end
end
