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

function wheeler(a=1.5)
    f(x::Vector{Float64}) = -exp(-(x[1] * x[2] - a) ^ 2  - (x[2] - a) ^ 2)
    function ∇f(x::Vector{Float64})
        return [
            -2 * y * f(x) * (x[1] * x[2] - a),
            -2 * f(x) * (x[2] * (x[1] ^ 2 + 1) - a * (x[1] + 1)),
        ]
    end
    return f, ∇f
end

end
