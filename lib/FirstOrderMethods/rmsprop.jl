mutable struct RMSProp <: DescentMethod
    α::Float64 # learning rate
    γ::Float64 # decay
    ϵ::Float64 # small value
    s::Vector{Float64} # sum of squared gradients
end

Base.summary(::RMSProp) = "RMSProp"

function RMSProp(; α=1e-3, γ=0.9, ϵ=1e-8, s::Vector{Float64})
    return RMSProp(α, γ, ϵ, s)
end

function step!(M::RMSProp, f, ∇f, x)
    g = ∇f(x)
    M.s = M.γ * M.s + (1 - M.γ) * g .^ 2
    return x - M.α * g ./ (M.ϵ .+ sqrt.(M.s))
end