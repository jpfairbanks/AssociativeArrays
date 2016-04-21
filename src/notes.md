# Original implementation of constructors
outer constructor infers the types from the data
triangular dispatch constraints are always satisfied if you use this constructor
these constructors use run time type functions so are unstable.
``` julia
function AssociativeArray(data, dims)
    nt, t = eltype(data).types
    a=length(nt.types)
    n = max(1, a)
    C = typeof(data)
    return AssociativeArray{t, n, C}(data, dims)
end

#special case for the 1D case so you can index by plain integers rather than (Int,)
function AssociativeArray(data, dims::Integer)
    nt, t = eltype(data).types
    return AssociativeArray{t, 1, typeof(data)}(data, (dims,))
end
```

# Response from tim holy on the list
On Thursday, April 14, 2016 11:54:45 AM James Fairbanks wrote:
```julia
function AssociativeArray(data, dims)
    nt, t = eltype(data).types
    n = length(nt.types)
    C = typeof(data)
    return AssociativeArray{t, n, C}(data, dims)
end
```
As you feared, using .types this way messes up inference. The better approach
is
AssociativeArray{K,V,N}(data::Associative{K,V}, dims::NTuple{N,Int}) =
AssociativeArray{V, N, typeof(data)}(data, dims)
 Your 1D constructor could just dispatch to this with AssociativeArray(data,
(dims,))

If you add @inline in front of the getindex/setindex! functions, you may be
able to eliminate the splatting penalty, and you won't need the 1D
specializations.
