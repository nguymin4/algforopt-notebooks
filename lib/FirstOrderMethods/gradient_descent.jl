struct GradientDescent <: DescentMethod
    α::Any
end

Base.summary(::GradientDescent) = "Gradient Descent"

function GradientDescent(; α::Float64=1e-3)
    return GradientDescent(α)
end

function step!(M::GradientDescent, f, ∇f, x)
    α, g = M.α, ∇f(x)
    return x - α * g
end
