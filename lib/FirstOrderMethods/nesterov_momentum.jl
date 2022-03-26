mutable struct NesterovMomentum <: DescentMethod
    α::Float64 # learning rate
    β::Float64 # momentum decay
    v::Vector{Float64} # momentum
end

Base.summary(::NesterovMomentum) = "Nesterov Momentum"

function NesterovMomentum(; α=1e-3, β=0.1, v::Vector{Float64})
    return NesterovMomentum(α, β, v)
end

function step!(M::NesterovMomentum, f, ∇f, x)
    g = ∇f(x + M.β * M.v)
    M.v = M.β * M.v - M.α * g
    return x + M.v
end
