mutable struct HyperNesterovMomentum <: DescentMethod
    α::Float64 # learning rate
    β::Float64 # momentum decay
    μ::Float64 # hypergradient learning rate
    v::Vector{Float64} # momentum
    g::Vector{Float64} # gradient
end

Base.summary(::HyperNesterovMomentum) = "Hyper Nesterov Momentum"

function HyperNesterovMomentum(; α=1e-3, β=0.1, μ=1e-8, v::Vector{Float64}, g::Vector{Float64})
    return HyperNesterovMomentum(α, β, μ, v, g)
end

"""
The implementation of Nesterov Momentum subtly differs from
Sutskever et. al. and implementations in some other frameworks.

See: `Online Learning Rate Adaptation with Hypergradient Descent` https://arxiv.org/abs/1703.04782
"""
function step!(M::HyperNesterovMomentum, f, ∇f, x)
    β, μ, prev_g = M.β, M.μ, M.g
    g = ∇f(x)
    M.α += μ * g' * (prev_g + β * M.v)
    M.v = β * M.v + g
    M.g = g
    return x - M.α * M.v
end
