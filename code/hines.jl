type tridiag
  b::Array{Float64,1}
  d::Array{Float64,1}
  a::Array{Float64,1}

  # constructor that takes three arrays describing the diagonals
  function tridiag(l::Array{Float64,1},
                   d::Array{Float64,1},
                   u::Array{Float64,1})
    n = length(d)
    @assert length(l) == n-1
    @assert length(u) == n-1
    # add NaN senitel to end of l and u, and initialise a, b and c
    new(cat(1,[NaN],l), d, cat(1,[NaN],u))
  end
end

# solve linear system using Hines algorithm
# the solution is stored in the rhs vector on return
function solve!(A::tridiag, rhs, net::network)
  n = length(rhs)

  # eliminate upper triangle
  for i = n:-1:2
    k = net.parent_indexes[i]

    # divide row k by dii
    p = A.a[i]/A.d[i]
    A.d[k] -= p*A.b[i]
    rhs[k] -= p*rhs[i]
  end

  # normalize d1
  rhs[1] /= A.d[1]

  # forward substitution
  for i=2:n
    k = net.parent_indexes[i]
    rhs[i] -= A.b[i] * rhs[k]
    rhs[i] /= A.d[i]
  end

  return None
end
