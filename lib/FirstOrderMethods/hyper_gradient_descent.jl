mutable struct HyperGradientDescent <: DescentMethod
    α::Float64
    μ::Float64
    g::Vector{Float64}
end

Base.summary(::HyperGradientDescent) = "Hyper Gradient Descent"

function HyperGradientDescent(; α=1e-3, μ=1e-3, g::Vector{Float64})
    return HyperGradientDescent(α, μ, g)
end

function step!(M::HyperGradientDescent, f, ∇f, x)
    prev_g = M.g
    g = ∇f(x)
    M.α += M.μ * g' * prev_g
    M.g = g
    return x - M.α * g
end
