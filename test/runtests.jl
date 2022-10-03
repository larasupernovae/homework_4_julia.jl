#using Pkg
#Pkg.instantiate(url="https://github.com/larasupernovae/homework_4_julia.jl")
#Pkg.add(url="https://github.com/larasupernovae/homework_4_julia.jl")
# add https://github.com/larasupernovae/homework_4_julia.jl
using homework_4_julia
using Test
using LinearAlgebra

# sve je tu

v = homework_4_julia.TrackingFloat(1.0) + homework_4_julia.TrackingFloat(3.0)
@test v == homework_4_julia.TrackingFloat(4,3)            # which we test using the macro @test
@test v*v == homework_4_julia.TrackingFloat(16, 4)
@test v - v == homework_4_julia.TrackingFloat(0, 4)
@test v/homework_4_julia.TrackingFloat(0.1, 0) == homework_4_julia.TrackingFloat(40, 10)

# Did we calculate correctly? Using value to convert back to float
@test maximum(homework_4_julia.abs, homework_4_julia.v - homework_4_julia.value.(homework_4_julia.vt)) < homework_4_julia.sqrt(eps())

# Is promotion working?
@test homework_4_julia.TrackingFloat(1.0, 0) + 2.0 == homework_4_julia.TrackingFloat(3, 2)

# Did we get the correct answer?
@test maximum(homework_4_julia.abs, homework_4_julia.value.(homework_4_julia.sol1) - homework_4_julia.AA\homework_4_julia.b) < homework_4_julia.sqrt(eps())