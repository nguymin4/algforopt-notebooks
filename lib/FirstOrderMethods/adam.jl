mutable struct Adam <: DescentMethod
    α::Float64 # learning rate
    γs::Float64 # gradient decay
    γv::Float64 # update decay
    ϵ::Float64 # small value
    k::Int64 # Iteration
    s::Vector{Float64} # sum squared gradients
    v::Vector{Float64} # sum squared updates
end

Base.summary(::Adam) = "Adam"

function Adam(; α=1e-3, γs=0.5, γv=0.5, ϵ=1e-8, k=0, s::Vector{Float64}, v::Vector{Float64})
    return Adam(α, γs, γv, ϵ, k, s, v)
end

function step!(M::Adam, f, ∇f, x)
    g = ∇f(x)
    M.k += 1
    γs, γv, k = M.γs, M.γv, M.k
    M.v = γv * M.v + (1 - γv) * g
    v_hat = M.v / (1 - γv^k)
    M.s = γs * M.s + (1 - γs) * g .^ 2
    s_hat = M.s / (1 - γs^k)
    return x - M.α * v_hat ./ (M.ϵ .+ sqrt.(s_hat))
end