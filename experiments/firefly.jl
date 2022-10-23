# Particle Swarm Optimization
using LinearAlgebra
using Random
using Distributions

include("../lib/test_functions.jl")
import .TestFunctions: branin

f = branin()
# f = branin(;a=1e-2, r=0.6, s=1.0)

xdomain = LinRange(-2π, 6π, 1000)
ydomain = LinRange(-π, 7π, 1000)

function initialize_population(population_size::Int64)
    X = nothing
    for (lb, ub) in zip([xdomain[1], ydomain[1]], [xdomain[end], ydomain[end]])
        X_at_dim = rand(Distributions.Uniform(lb, ub), population_size)'
        X = X === nothing ? X_at_dim : vcat(X, X_at_dim)
    end
    return [Vector(x) for x in eachcol(X)]
end

function firefly(
    f; β=1.0, α=0.1, brightness=r -> exp(-(r + 1e-8)^2), population_size=20, max_iter=10
)
    population = initialize_population(population_size)
    n = length(population[1])
    noise_distribution = MvNormal(Matrix(1.0I, n, n))

    history = []
    push!(history, deepcopy(population))
    for _ in 1:max_iter
        for a in population, b in population
            if f(b) < f(a)
                delta = b - a
                r = norm(b - a)
                a[:] += β * brightness(r) * delta + α * rand(noise_distribution)
            end
        end
        push!(history, deepcopy(population))
    end
    y = f.(population)
    return population[argmin(y)], history
end

# Random.seed!(0)
x, histories = @time firefly(f; β=1.0, α=0.1, population_size=200, max_iter=10);
display("Optimum: x=$(round.(x, digits=4)), y=$(f(x))")

# Visualize firefly optimization
using GLMakie
using DataStructures

set_theme!(theme_black())

function visualize_firefly_optimization(
    f,
    xdomain,
    ydomain,
    histories;
    animation_interval=24,
    trajectory_tail=50,
    particle_color=:green,
    plot_size=(600, 600),
    record_file=nothing,
)
    figure, ax = contour(
        xdomain,
        ydomain,
        [f([x, y]) for x in xdomain, y in ydomain];
        # axis=(; type=Axis3, elevation=0.3π, protrusions=(0, 0, 0, 40)),
        levels=[1, 2, 3, 5, 10, 20, 50, 100],
        colorrange=(0, 100),
    )
    resize!(figure.scene, plot_size)

    # Initialize particles and trajectories
    particles = Observable([Point3f([p[1], p[2], f(p)]) for p in histories[1]])
    trajectories = []
    for point in particles.val
        trajectory = CircularBuffer{Point3f}(trajectory_tail)
        fill!(trajectory, point)
        push!(trajectories, Observable(trajectory))
    end

    # Plot particles
    scatter!(ax, particles; markersize=8, color=particle_color, strokewidth=0)

    # Plot trajectories
    c = to_color(particle_color)
    tail_colors = [RGBAf(c.r, c.g, c.b, (i / trajectory_tail)^4) for i in 1:trajectory_tail]
    for trajectory in trajectories
        lines!(ax, trajectory; linewidth=3, color=tail_colors)
    end

    function animate(after_update)
        counter = 1
        prev_history = histories[1]
        for history in histories[2:end]
            steps = [[p; 0] for p in history .- prev_history] / animation_interval
            for _ in 1:animation_interval
                next_points = particles.val .+ steps
                next_points = [[p[1:2]; f(p[1:2])] for p in next_points]
                for (next_point, trajectory) in zip(next_points, trajectories)
                    push!(trajectory[], next_point)
                end
                particles[] = next_points
                notify.(trajectories)
                # ax.azimuth[] = 1.7pi + 0.5 * sin(2pi * counter / 240)
                after_update()
                counter += 1
            end
            prev_history = history
        end
    end

    if record_file === nothing
        display(figure)
        sleep(0.1)
        after_update = () -> sleep(1 / animation_interval)
        animate(after_update)
    else
        record(figure, record_file) do frame
            animate(() -> recordframe!(frame))
        end
    end
end

visualize_firefly_optimization(
    f,
    xdomain,
    ydomain,
    histories;
    animation_interval=24,
    trajectory_tail=50,
    # record_file="./temp/firefly_branin.mkv",
    particle_color=:pink,
    plot_size=(800, 800),
)
