module FirstOrderMethods

export optimize, DescentMethod, GradientDescent, Momentum, NesterovMomentum

include("types.jl")
include("gradient_descent.jl")
include("momentum.jl")
include("nesterov_momentum.jl")
include("optimize.jl")

end
