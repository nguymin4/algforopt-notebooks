module FirstOrderMethods

export optimize,
    DescentMethod,
    Adadelta,
    Adagrad,
    Adam,
    GradientDescent,
    HyperGradientDescent,
    HyperNesterovMomentum,
    Momentum,
    NesterovMomentum,
    RMSProp

include("types.jl")
include("adadelta.jl")
include("adagrad.jl")
include("adam.jl")
include("gradient_descent.jl")
include("hyper_gradient_descent.jl")
include("hyper_nesterov.jl")
include("momentum.jl")
include("nesterov_momentum.jl")
include("rmsprop.jl")
include("optimize.jl")

end
