using Pkg
Pkg.add("https://github.com/larasupernovae/homework_4_julia.jl")
using Test

@test v     == TrackingFloat(4,3)            # which we test using the macro @test
@test v*v   == TrackingFloat(16, 4)
@test v - v == TrackingFloat(0, 4)
@test v/TrackingFloat(0.1, 0) == TrackingFloat(40, 10)

# Did we calculate correctly? Using value to convert back to float
@test maximum(abs, v - value.(vt)) < sqrt(eps())

# Is promotion working?
@test TrackingFloat(1.0, 0) + 2.0 == TrackingFloat(3, 2)

# Did we get the correct answer?
@test maximum(abs, value.(sol1) - AA\b) < sqrt(eps())

@test maximum(abs, value.(sol2) - AA\b) < sqrt(eps())