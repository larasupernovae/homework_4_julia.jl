#using Pkg
#Pkg.instantiate(url="https://github.com/larasupernovae/homework_4_julia.jl")
#Pkg.add(url="https://github.com/larasupernovae/homework_4_julia.jl")
# add https://github.com/larasupernovae/homework_4_julia.jl
using homework_4_julia
using Test
using LinearAlgebra

v = homework_4_julia.TrackingFloat(1.0) + homework_4_julia.TrackingFloat(3.0)
@test v == homework_4_julia.TrackingFloat(4,3)            # which we test using the macro @test

#@test v*v   == homework_4_julia.TrackingFloat(16, 4)
#@test v - v == homework_4_julia.TrackingFloat(0, 4)
#@test v/homework_4_julia.TrackingFloat(0.1, 0) == homework_4_julia.TrackingFloat(40, 10)

# Did we calculate correctly? Using value to convert back to float
#@test maximum(abs, v - value.(vt)) < sqrt(eps())

# Is promotion working?
@test homework_4_julia.TrackingFloat(1.0, 0) + 2.0 == homework_4_julia.TrackingFloat(3, 2)

# Did we get the correct answer?
#@test maximum(abs, value.(sol1) - AA\b) < sqrt(eps())

#@test maximum(abs, value.(sol2) - AA\b) < sqrt(eps())