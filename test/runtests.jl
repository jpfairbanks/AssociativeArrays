using AssociativeArrays
using Base.Test

# write your own tests here
@test 1 == 1
# check that we can instantiate AssociativeArrays
d = Dict{NTuple{2,Int}, Float64}()
twod_itof = AssociativeArray(d, (5,5))
@test typeof(AssociativeArray(Dict{NTuple{2,Int},Int}(), (5,6))) == AssociativeArray{Int, 2, Dict{NTuple{2,Int}, Int}}
Dict{NTuple{2,Int}, Int}()

# check that access and assignment work correctly
a = Dict{NTuple{2,Int}, Int}()
a[(3,4)] = 1
@test a[(3,4)] == 1
sa = AssociativeArray(a, (5,5))
@test typeof(sa) == AssociativeArray{Int, 2, Dict{NTuple{2,Int}, Int}}
@test size(sa) == (5,5)
@show getindex(sa, 3,4)
sa[4,4] = -2
@test sa[4,4] == -2
setindex!(sa, -1, 4,4)
@test sa[4,4] == -1
println(sa)
@show fa = similar(sa, Float64, (3,3))
@show fa[3,3] = 1
@show fa

info("special 1d case")
oned_itoi = AssociativeArray(Dict{Int,Int}(), 5)
@show oned_itoi
oned_itoi[4] = 1
@test oned_itoi[4] == 1
@show oned_itoi
@show similar(oned_itoi, Float64, 3)
@show sim1 = similar(oned_itoi, UInt8, 3)
@test length(sim1.data) == 0
a = AssociativeArray{Float64, 2, Dict{Int, Float64}}(Dict{Int, Float64}(), (3,4));

@test_throws MethodError AssociativeArray(Dict{Int, Int}(), (3,4), Float64)
dat = Dict{NTuple{2,Int}, Int}()
# AssociativeArray(dat, (3,4), Int)
