# interesting fact: nonvint stands for "non voltage integration"
# because here we integrate the currents
function nonvint(cell_group)
  for mechanism in cell_group.mechanisms
    state(mechanism)
  end
end
