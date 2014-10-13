function nrn_solve_minimal(thread)
    child_nodes = ncells+1:nnodes

    for i in reverse(child_nodes)
        factor         = VEC_A[i] / VEC_D[i]
        VEC_D[p[i]]   -= factor * VEC_B[i]
        VEC_RHS[p[i]] -= factor * VEC_RHS[i]
    end

    for i in 1:ncells
        VEC_RHS[i] /= VEC_D[i];
    end

    for i in child_nodes
        VEC_RHS[i] -= VEC_B[i] * VEC_RHS[p[i]]
        VEC_RHS[i] /= VEC_D[i]
    end
end
