import Plots as plt

include("../lib/test_functions.jl")
import .TestFunctions: rosenbrock

include("../lib/FirstOrderMethods/FirstOrderMethods.jl")
using .FirstOrderMethods

plt.plotlyjs()

function plot_contour!(plot, f, xdomain, ydomain)
    X = repeat(reshape(xdomain, 1, :), length(ydomain), 1)
    Y = repeat(ydomain, 1, length(xdomain))
    Z = map((x, y) -> f([x, y]), X, Y)
    return plt.contour!(plot, xdomain, ydomain, Z; levels=1:80:400, colorbar=false, color=:ice)
end

function plot_optimize_process!(plot, method::DescentMethod, f, ∇f, x0)
    pts = optimize(method, f, ∇f, x0; iteration=40)
    xs = [P[1] for P in pts]
    ys = [P[2] for P in pts]
    return plt.plot!(plot, xs, ys; label=summary(method))
end

function run_example()
    f, ∇f = rosenbrock(1, 100, 4)
    xdomain = range(-3, 2, 150)
    ydomain = range(-0.5, 2, 150)
    x0 = [-2, 1.5]

    plot = plt.plot(; size=(800, 400), palette=:seaborn_muted)
    plot_contour!(plot, f, xdomain, ydomain)
    # plot_optimize_process!(plot, GradientDescent(3e-4), f, ∇f, x0)
    # plot_optimize_process!(plot, Momentum(3e-4, 0.9, zeros(2)), f, ∇f, x0)
    # plot_optimize_process!(plot, NesterovMomentum(2e-4, 0.92, zeros(2)), f, ∇f, x0)
    # plot_optimize_process!(plot, Adagrad(0.5, 1e-8, zeros(2)), f, ∇f, x0)
    # plot_optimize_process!(plot, RMSProp(0.65, 0.45, 1e-8, zeros(2)), f, ∇f, x0)
    # plot_optimize_process!(plot, Adadelta(0.8, 0.8, 1e-3, zeros(2), zeros(2)), f, ∇f, x0)
    # plot_optimize_process!(plot, Adam(α=0.8, γs=0.9, γv=0.9, s=zeros(2), v=zeros(2)), f, ∇f, x0)
    plot_optimize_process!(plot, HyperGradientDescent(4e-4, 8e-13, zeros(2)), f, ∇f, x0)
    plot_optimize_process!(plot, HyperNesterovMomentum(2e-4, 0.93, 1e-12, zeros(2), zeros(2)), f, ∇f, x0)
    return display(plot)
end


run_example()