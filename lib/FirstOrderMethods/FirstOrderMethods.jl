module FirstOrderMethods

export optimize, DescentMethod, Adadelta, Adagrad, Adam, GradientDescent, Momentum, NesterovMomentum, RMSProp

include("types.jl")
include("adadelta.jl")
include("adagrad.jl")
include("adam.jl")
include("gradient_descent.jl")
include("momentum.jl")
include("nesterov_momentum.jl")
include("rmsprop.jl")
include("optimize.jl")

end
