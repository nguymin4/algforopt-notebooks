mutable struct Adagrad <: DescentMethod
    α::Float64 # learning rate
    ϵ::Float64 # small value
    s::Vector{Float64} # sum squared gradients
end

Base.summary(::Adagrad) = "Adagrad"

function Adagrad(; α=1e-3, ϵ=1e-8, s::Vector{Float64})
    return Adagrad(α, ϵ, s)
end

function step!(M::Adagrad, f, ∇f, x)
    g = ∇f(x)
    M.s += g .^ 2
    return x - M.α * g ./ (M.ϵ .+ sqrt.(M.s))
end