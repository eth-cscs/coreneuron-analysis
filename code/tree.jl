# a neuron graph is represented as a set of connections between
# nodes and weights for the connections
type network
  connections::Array{Array{Int64, 1}, 1}
  segments::Array{Array{Int64, 1}, 1}
  node_indexes::Array{Int64, 1}
  parent_indexes::Array{Int64, 1}
  function network()
    node_indexes = Int64[1]
    parent_indexes = Int64[0]
    new( Array[Int64[]],
         Array[Int64[]],
         node_indexes,
         parent_indexes)
  end
end

# add a node to a network
# the value of node is the node in n to which we are connected
function add_node!(n::network, node::Int64, segments::Int64=1)
  node_index = number_of_nodes(n)+1
  @assert node < node_index

  # create empty connection set for the new node
  push!(n.connections, Int64[])
  push!(n.segments, Int64[])

  # list the new node as a child of it's parent, by inserting it into
  # its parent node's connections and segments lists
  push!(n.connections[node], node_index)
  push!(n.segments[node], segments)

  # get the number of segments in the network before this
  # section was added
  current_index = number_of_segments(n)
  parent_index = n.node_indexes[node]
  next_index = current_index + segments-1
  # add the index for the new node
  push!(n.node_indexes, next_index)
  # add parent indexes for all segments in the new section
  n.parent_indexes = cat(1, n.parent_indexes,
                            [parent_index, current_index+1:next_index])

  return None
end

# build the network from Fig. 4
net = network()
add_node!(net, 1, 5) # add s1
add_node!(net, 1, 5) # add s2
add_node!(net, 2, 5) # add s3
add_node!(net, 3, 5) # add s4
add_node!(net, 1, 5) # add s5
