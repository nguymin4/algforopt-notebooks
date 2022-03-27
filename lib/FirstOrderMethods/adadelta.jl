mutable struct Adadelta <: DescentMethod
    γg::Float64 # gradient decay
    γx::Float64 # update decay
    ϵ::Float64 # small value
    sg::Vector{Float64} # sum squared gradients
    sx::Vector{Float64} # sum squared updates
end

Base.summary(::Adadelta) = "Adadelta"

function Adadelta(; γg=0.5, γx=0.5, ϵ=1e-8, sg::Vector{Float64}, sx::Vector{Float64})
    return Adadelta(γg, γx, ϵ, sg, sx)
end

function step!(M::Adadelta, f, ∇f, x)
    g = ∇f(x)
    M.sg = M.γg * M.sg + (1 - M.γg) * g .^ 2
    Δx = -(M.ϵ .+ sqrt.(M.sx)) .* g ./ (M.ϵ .+ sqrt.(M.sg))
    M.sx = M.γx * M.sx + (1 - M.γx) * Δx .^ 2
    return x + Δx
end