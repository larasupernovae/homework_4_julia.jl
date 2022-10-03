# These instructions might be long, they contain many examples and some hints.
# Although the instructions might seem complicated, you don't need any complicated code,
# it is possible to solve part 1 in 20 quite simple lines of code
# If you can run the code below, you have probably done everything needed

##################### Specification part 1
# Define your own type
# TrackingFloat <: AbstractFloat
# that keeps track of the largest value it has interacted with.
# This can be used as as rough way of tracking how numerically problematic an algorithm is.
#
# It should keep two fields, one Float64 that acts as a normal float under all the
# specified operations below, and one field that keeps track of the largest number
# (in absolute value) that has been involved in generating this TrackingFloat.
#
# Example: v = TrackingFloat(1) + TrackingFloat(3) should generate a
# TrackingFloat v, with value 4, that remembers that 3 is the largest value
# used to generate it so far, we write this as
# v = TrackingFloat(4, 3), i.e value 4, memory 3
# Some examples:
# v + TrackingFloat(2), results in TrackingFloat(6, 4)
# v + TrackingFloat(5), results in TrackingFloat(9, 5)
# v + TrackingFloat(-5), results in TrackingFloat(-1, 5)
# v - TrackingFloat(5), results in TrackingFloat(-1, 5)
# TrackingFloat(4, 5) - TrackingFloat(1, 3), results in TrackingFloat(3, 5)

#################### Part 1 simple operations
# Test your type
using Test
using LinearAlgebra
import Base: +, *, -, /, sqrt, <, promote_rule

struct TrackingFloat <: AbstractFloat
  x::Float64
  y::Float64  
end

function +(prva::TrackingFloat, druga::TrackingFloat) 
  zbir = prva.x + druga.x; maksimum = max(abs(prva.x), abs(druga.x))
  return TrackingFloat(zbir,maksimum)
end

function *(prva::TrackingFloat, druga::TrackingFloat) 
  puta = prva.x * druga.x; maksimum = max(abs(prva.x), abs(druga.x))
  return TrackingFloat(puta,maksimum)
end

function -(prva::TrackingFloat, druga::TrackingFloat) 
  minus = prva.x - druga.x; maksimum = max(abs(prva.x), abs(druga.x))
  return TrackingFloat(minus,maksimum)
end

function /(prva::TrackingFloat, druga::TrackingFloat) 
  podeljeno = prva.x/druga.x
      if druga.x < 1.0
        maksimum = max(abs(prva.x), 1/abs(druga.x))
      else 
        maksimum = max(abs(prva.x), abs(druga.x))
      end
  return TrackingFloat(podeljeno,maksimum)
end

TrackingFloat(x) = TrackingFloat(x, x)
TrackingFloat(v::TrackingFloat) = v

v = +(1.0, 3.0)

# Example: v = TrackingFloat(1) + TrackingFloat(3) should generate a
# TrackingFloat v, with value 4, that remembers that 3 is the largest value
# used to generate it so far, we write this as
# v = TrackingFloat(4, 3), i.e value 4, memory 3

v = TrackingFloat(1.0) + TrackingFloat(3.0) # We expect TrackingFloat(4, 3)                  # sama stvori TrackingFloat

v + TrackingFloat(2)                         # results in TrackingFloat(6, 4)
v + TrackingFloat(5)                         # results in TrackingFloat(9, 5)
v + TrackingFloat(-5)                        # results in TrackingFloat(-1, 5)
v - TrackingFloat(5)                         # results in TrackingFloat(-1, 5)
TrackingFloat(4, 5) - TrackingFloat(1, 3)    # results in TrackingFloat(3, 5)
@test v     == TrackingFloat(4,3)            # which we test using the macro @test
@test v*v   == TrackingFloat(16, 4)
@test v - v == TrackingFloat(0, 4)
@test v/TrackingFloat(0.1, 0) == TrackingFloat(40, 10)
TrackingFloat(3.0)/TrackingFloat(0.1)        # should result in TrackingFloat(30, 10)

##################### Specification Part 2:
# It should work with operations such as +, -, *, /
# For +, -, * the output should be as described above.
# However for /, we want to be wary of dividing by small numbers instead, so
# TrackingFloat(3.0)/TrackingFloat(0.1) should result in TrackingFloat(30, 10)
# i.e as if we had the equations 3.0*(1/0.1) instead.

# Define constructor that works as:
# TrackingFloat(1.0), generating TrackingFloat(1.0, 0.0)

# Define simple getters `value` and `getmax` that gets the corresponding fileds.

# Note:
# Don't forget to `import Base: +, *, -, /`
# before trying to add methods to these functions
# Try working with matrices

A = randn(10,10)
b = randn(10)

# Convert using broadcast
At = TrackingFloat.(A)
bt = TrackingFloat.(b)

# Try some operations
v = A*b
vt = At*bt

##################### Specification Part 3:
# We now want to be able to do more complicated calculations,
# such as cholesky and qr factorization

# Start by defining a `promote_rule` so that you can write for example
# TrackingFloat(1.0, 0) + 1.0
# You can look at the documentation on promote_rule to figure out how to do it.
# One example of promote_rule from Base is
# promote_rule(::Type{Bool}, ::Type{T}) where {T<:Number} = T
# Which says that whenever you want to make a Bool and a Number to be of the same type,
# they should become the type of that Number.

# You will also need to define the following functions:
# sqrt, -, <

# Lastly, if you have problems that the qr or cholesky functions fail in
# promoting properly, try to define the function below to make sure julia is not trying
# to put a TrackingFloat inside another TrackingFloat, i.e.
# TrackingFloat(v::TrackingFloat) = v

function sqrt(prva::TrackingFloat) 
   kvadratnikoren = sqrt(prva.x); maksimum = max(abs(prva.x), abs(prva.y))
   return TrackingFloat(kvadratnikoren,maksimum)
end

value(prva::TrackingFloat) = prva.x
getmax(druga::TrackingFloat) = druga.y

function -(prva::TrackingFloat)
  menjajznak = -(prva.x); maksimum = max(abs(prva.x), abs(prva.y))
  return TrackingFloat(menjajznak,maksimum)
end

function <(prva::TrackingFloat,druga::TrackingFloat)
  res = prva.x < druga.x
  return res
end

# Did we calculate correctly? Using value to convert back to float
@test maximum(abs, v - value.(vt)) < sqrt(eps())

# Get the max fields using our function getmax
getmax.(vt)

#################### Part 2: Lets try something more complicated

promote_rule(::Type{TrackingFloat}, ::Type{S}) where {S<:Number} = TrackingFloat
# Is promotion working?
@test TrackingFloat(1.0, 0) + 2.0 == TrackingFloat(3, 2)

# Create Positive definite matrix
AA = A*A'
# Convert to TrackingFloat matrix
AAt = TrackingFloat.(AA)

sol1 = AAt\bt # Uses qr
# Did we get the correct answer?
@test maximum(abs, value.(sol1) - AA\b) < sqrt(eps())

# Try cholesky factorization
F = cholesky(AAt)               # ovde moras da probas da stvoris metodu

sol2 = F\bt
@test maximum(abs, value.(sol2) - AA\b) < sqrt(eps())

# Which method was able to work with smallest elements?
maximum(getmax.(sol1))
maximum(getmax.(sol2))


####### Optional part
# This can be a bit trickier, so it is completely optional:
# Make TrackingFloat parametric, e.g
# TrackingFloat{T<:Real}, so that
# TrackingFloat{Int64} + TrackingFloat{Int64} isa TrackingFloat{Int64}
# Can you make the following work too?
# TrackingFloat{Int64} + TrackingFloat{Float64} isa TrackingFloat{Float64}

struct TrackingFloatN{T}
    x::T
end

function +(prva::TrackingFloatN{T}, druga::TrackingFloatN{T}) where T <: Real
    zbir = prva.x + druga.x
    return TrackingFloatN{T}(zbir)
end

function +(::Type{TrackingFloatN{T}},::Type{TrackingFloatN{T}}) where T <: Real
    return TrackingFloatN{T}
end

import Base:isequal, isa

bla = TrackingFloatN{Int64}(2) + TrackingFloatN{Int64}(2) 

TrackingFloatN{Int64} + TrackingFloatN{Int64} isa TrackingFloatN{Int64}