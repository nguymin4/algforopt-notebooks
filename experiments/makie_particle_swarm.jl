# Particle Swarm Optimization
using LinearAlgebra
using Random: Random
using Distributions: Distributions

include("../lib/test_functions.jl")
import .TestFunctions: michalewicz, ackley, wheeler

f = michalewicz(10)
# f = ackley()
# f, ∇f = wheeler(1.5)

xdomain = LinRange(-5, 5, 400)
ydomain = LinRange(-5, 5, 400)

mutable struct Particle
    x::Vector{Float64}
    v::Vector{Float64}
    x_best::Vector{Float64}
end

function initialize_population(f, population_size::Int64)
    X = nothing
    for (lb, ub) in zip([xdomain[1], ydomain[1]], [xdomain[end], ydomain[end]])
        X_at_dim = rand(Distributions.Uniform(lb, ub), population_size)'
        X = X === nothing ? X_at_dim : vcat(X, X_at_dim)
    end
    V = rand(Float64, size(X))
    population = [Particle(x, v, x) for (x, v) in zip(eachcol(X), eachcol(V))]

    Y = mapslices(f, X; dims=1)[1, :]
    min_y_idx = argmin(Y)
    x_best, y_best = copy(X[:, min_y_idx]), Y[min_y_idx]
    return population, x_best, y_best, length(x_best)
end

function particle_swarm(
    f; w::Float64=1.0, c1::Float64=1.0, c2::Float64=1.0, population_size=20, max_iter=10
)
    history = []
    population, x_best, y_best, n = initialize_population(f, population_size)
    push!(history, deepcopy(population))
    for _ in 1:max_iter
        for individual in population
            r1, r2 = rand(n), rand(n)
            individual.v =
                w * individual.v +
                c1 * r1 .* (individual.x_best - individual.x) +
                c2 * r2 .* (x_best - individual.x)
            individual.x += individual.v
            y = f(individual.x)
            if y < y_best
                x_best, y_best = copy(individual.x), y
            end
            if y < f(individual.x_best)
                individual.x_best = copy(individual.x)
            end
        end
        push!(history, deepcopy(population))
    end
    y = map(individual -> f(individual.x), population)
    return population[argmin(y)].x, history
end

# Random.seed!(0)
x, histories = @time particle_swarm(
    f; w=1e-2, c1=0.75, c2=0.75, population_size=200, max_iter=10
);
display("Optimum: x=$(round.(x, digits=4))")

# Visualize particle swarm optimization
using GLMakie
using DataStructures

function visualize_particle_swarm_optimization_2D(
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
    figure, ax, = contour(
        xdomain,
        ydomain,
        [f([x, y]) for x in xdomain, y in ydomain];
        colormap=:vik,
        enable_depth=true,
        inspectable=false,
        levels=8,
        overdraw=true,
    )
    ax.aspect = DataAspect()
    xlims!(xdomain[1], xdomain[end])
    ylims!(ydomain[1], ydomain[end])
    resize!(figure.scene, plot_size)

    # Initialize particles and trajectories
    particles = Observable([Point2f(p.x[1], p.x[2]) for p in histories[1]])
    trajectories = []
    for point in particles.val
        trajectory = CircularBuffer{Point2f}(trajectory_tail)
        fill!(trajectory, point)
        push!(trajectories, Observable(trajectory))
    end

    # Plot particles
    scatter!(
        ax,
        particles;
        marker=:circle,
        strokewidth=0,
        strokecolor=particle_color,
        color=particle_color,
        markersize=16,
    )

    # Plot trajectories
    c = to_color(particle_color)
    tail_colors = [RGBAf(c.r, c.g, c.b, (i / trajectory_tail)^4) for i in 1:trajectory_tail]
    for trajectory in trajectories
        lines!(ax, trajectory; linewidth=4, color=tail_colors)
    end

    function animate(after_update)
        for next_history in histories[2:end]
            steps = [p.v for p in next_history] / animation_interval
            for _ in 1:animation_interval
                next_points = particles.val .+ steps
                for (next_point, trajectory) in zip(next_points, trajectories)
                    push!(trajectory[], next_point)
                end
                particles[] = next_points
                notify.(trajectories)
                after_update()
            end
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

function visualize_particle_swarm_optimization_3D(
    f,
    xdomain,
    ydomain,
    histories;
    animation_interval=24,
    trajectory_tail=50,
    particle_color=:green,
    plot_size=(600, 600, 600),
    record_file=nothing,
)
    figure, ax = surface(
        xdomain,
        ydomain,
        [f([x, y]) for x in xdomain, y in ydomain];
        shading=true,
        # colormap=:vik,
        axis=(; type=Axis3, elevation=0.3π, protrusions=(0, 0, 0, 40)),
    )
    resize!(figure.scene, plot_size)

    # Initialize particles and trajectories
    particles = Observable([Point3f([p.x[1], p.x[2], f(p.x)]) for p in histories[1]])
    trajectories = []
    for point in particles.val
        trajectory = CircularBuffer{Point3f}(trajectory_tail)
        fill!(trajectory, point)
        push!(trajectories, Observable(trajectory))
    end

    # Plot particles
    meshscatter!(ax, particles; color=particle_color, markersize=4e-2)

    # Plot trajectories
    c = to_color(particle_color)
    tail_colors = [RGBAf(c.r, c.g, c.b, (i / trajectory_tail)^4) for i in 1:trajectory_tail]
    for trajectory in trajectories
        lines!(ax, trajectory; linewidth=4, color=tail_colors, fxaa=true)
    end

    function animate(after_update)
        counter = 1
        for history in histories[2:end]
            steps = [[p.v[1], p.v[2], 0] for p in history] / animation_interval
            for _ in 1:animation_interval
                next_points = particles.val .+ steps
                next_points = [[p[1:2]; f(p[1:2])] for p in next_points]
                for (next_point, trajectory) in zip(next_points, trajectories)
                    push!(trajectory[], next_point)
                end
                particles[] = next_points
                notify.(trajectories)
                ax.azimuth[] = 1.7pi + 0.5 * sin(2pi * counter / 240)
                after_update()
                counter += 1
            end
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

set_theme!(theme_black())

visualize_particle_swarm_optimization_2D(
    f,
    xdomain,
    ydomain,
    histories;
    animation_interval=42,
    trajectory_tail=100,
    record_file="./experiments/docs/pso_michalewicz.mkv",
    particle_color=:pink,
    plot_size=(2560, 1440),
)
