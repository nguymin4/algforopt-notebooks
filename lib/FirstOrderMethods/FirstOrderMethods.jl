module FirstOrderMethods

export optimize, DescentMethod, GradientDescent, Momentum

include("types.jl")
include("gradient_descent.jl")
include("momentum.jl")
include("optimize.jl")

end
