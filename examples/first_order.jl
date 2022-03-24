import Plots as plt

include("../lib/test_functions.jl")
import .TestFunctions: rosenbrock

include("../lib/FirstOrderMethods/FirstOrderMethods.jl")
import .FirstOrderMethods: optimize,
    DescentMethod,
    GradientDescent,
    Momentum

plt.plotlyjs()

function plot_contour!(plot, f, xdomain, ydomain)
    X = repeat(reshape(xdomain, 1, :), length(ydomain), 1)
    Y = repeat(ydomain, 1, length(xdomain))
    Z = map((x, y) -> f([x, y]), X, Y)
    plt.contour!(plot, xdomain, ydomain, Z, levels=1:80:400, colorbar=false)
end

function plot_optimize_process!(plot, method::DescentMethod, f, ∇f, x0)
    pts = optimize(method, f, ∇f, x0; iteration=40)
    xs = [P[1] for P in pts]
    ys = [P[2] for P in pts]
    plt.plot!(plot, xs, ys, label=summary(method))
end

function run_example()
    f, ∇f = TestFunctions.rosenbrock(1, 100, 4)
    xdomain = range(-3, 2, 150)
    ydomain = range(-0.5, 2, 150)
    x0 = [-2, 1.5]

    plot = plt.plot(size=(800, 400))
    plot_contour!(plot, f, xdomain, ydomain)
    plot_optimize_process!(plot, GradientDescent(3e-4), f, ∇f, x0)
    plot_optimize_process!(plot, Momentum(3e-4, 0.9, zeros(2)), f, ∇f, x0)
    display(plot)
end
