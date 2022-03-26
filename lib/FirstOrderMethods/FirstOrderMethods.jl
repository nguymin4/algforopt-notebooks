module FirstOrderMethods

export optimize, DescentMethod, Adagrad, GradientDescent, Momentum, NesterovMomentum

include("types.jl")
include("adagrad.jl")
include("gradient_descent.jl")
include("momentum.jl")
include("nesterov_momentum.jl")
include("optimize.jl")

end
