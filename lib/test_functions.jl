module TestFunctions

function rosenbrock(a::Real, b::Real, c=1::Real)
    f(x::Vector{Float64}) = (a - x[1])^2 + b * (c * x[2] - x[1]^2)^2
    function ∇f(x::Vector{Float64})
        return [
            4 * b * x[1]^3 - 4 * b * c * x[1] * x[2] + 2x[1] - 2 * a,
            2 * b * c * (c * x[2] - x[1]^2),
        ]
    end
    return f, ∇f
end

end
