module AssociativeArrays

export AssociativeArray

import Base: getindex, setindex!, size, similar
using Base.Test

immutable AssociativeArray{T,N,C<:Associative} <: AbstractArray{T,N}
    data::C
    dims::NTuple{N,Int}
end

AssociativeArray{K,V,N}(data::Associative{K,V}, dims::NTuple{N,Int}) = AssociativeArray{V, N, typeof(data)}(data, dims)
AssociativeArray(data::Associative, dims::Int) = AssociativeArray(data, (dims,))

# outer constructor infers the types from the data
# triangular dispatch constraints are always satisfied if you use this constructor
# these constructors use run time type functions so are unstable.
# function AssociativeArray(data, dims)
#     nt, t = eltype(data).types
#     a=length(nt.types)
#     n = max(1, a)
#     C = typeof(data)
#     return AssociativeArray{t, n, C}(data, dims)
# end
# #special case for the 1D case so you can index by plain integers rather than (Int,)
# function AssociativeArray(data, dims::Integer)
#     nt, t = eltype(data).types
#     return AssociativeArray{t, 1, typeof(data)}(data, (dims,))
# end

# this doesn't work because you can't pass a Dict you need to instantiate
# is with something in order to instantiate it.
# type SparseVec{T,N,C<:Associative}
#   data::C{T,N}
#   dims::N
# end

# this doesn't work because you can't nest parametric types.
# type SparseVec{T,N,C<:Associative{N,T}}
#     data::C
#     dims::N
# end

# satisfying the interface
size(sa::AssociativeArray) = sa.dims
@inline getindex(sa::AssociativeArray, indices...) = sa.data[indices]
@inline setindex!(sa::AssociativeArray, x, indices...) = setindex!(sa.data, x, indices)
similar{T}(sa::AssociativeArray, ::Type{T}, dims) = AssociativeArray(Dict{typeof(dims), T}(), dims)
#special 1d case
@inline getindex{T,C<:Associative}(sa::AssociativeArray{T,1,C}, index::Integer) = sa.data[index]
@inline setindex!{T,C<:Associative}(sa::AssociativeArray{T,1,C}, x, index::Integer) = setindex!(sa.data, x, index)

# TODO enable abbreviated printing.
# println(AssociativeArray(Dict{NTuple{2, Int}, Float64}(), (150,150)))

type SparseVector{T,C}
    data::C
    length::NTuple{1, Int}
end
end
