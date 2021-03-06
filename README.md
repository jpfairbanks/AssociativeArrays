# AssociativeArrays
AssociativeArrays wrap Associative collections to make them more like Arrays.
[![Build Status](https://travis-ci.org/jpfairbanks/AssociativeArrays.jl.svg?branch=master)](https://travis-ci.org/jpfairbanks/AssociativeArrays.jl)

We present a subtype of `AbstractArray{T,N}` that contains wraps an `Associative{Ntuple{N,Int}, T}` so that you can use it like an array. The access is `LinearSlow` and the data is stored based on the Associative you chose. The most commonly used `Associative` in Julia is the `Dict` type which is implemented as a hash map. You can wrap a `Dict` into an array and then use it like an array. 

The idea is that you can use a hash map as a sparse array. It won't often be the optimal structure, but it gives you correctness and performance guarantees that are simple to reason about. For example you know that insert and lookup are O(1) no matter the order in which they are performed. This time is usually higher than for a standard `Array`, but compare that to a `Base.SparseArray` which is a one column CSC representation. For such an array, traversal is O(nnz), but looking up an arbitrary element is worst case log(nnz) because you need to bisection search for it. For this reason this package presents an `AssociativeArray` based on whatever backing store you want. If you want to use your favorite data structure you can but this basic implementation offers correctness and O(1) insertion/modification and lookup.

## TODO List
- [ ] Support sparse printing
- [ ] Support condensed printing like Base.Array

