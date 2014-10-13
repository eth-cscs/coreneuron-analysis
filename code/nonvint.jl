function nonvint(thread)
  for mechanism in thread.mechanisms
    mechanism.state(thread, mechanism.data)
  end
end
