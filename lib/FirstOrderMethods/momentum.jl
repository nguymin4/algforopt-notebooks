mutable struct Momentum <: DescentMethod
    α::Float64 # learning rate
    β::Float64 # momentum decay
    v::Vector{Float64} # momentum
end

Base.summary(::Momentum) = "Momentum"

function Momentum(;α=1e-3,β=0.1,v::Vector{Float64})
    return Momentum(α, β, v)
end

function step!(M::Momentum, f, ∇f, x)
    α, β, v, g = M.α, M.β, M.v, ∇f(x)
    M.v = β * v - α * g
	return x + M.v
end
