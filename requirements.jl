import Pkg

dependencies = [
    "ColorSchemes",
    "Colors",
    "DataStructures",
    "Discretizers",
    "Distributions",
    "ExprRules",
    "ForwardDiff",
    "GLMakie",
    "ImageMagick",
    "IterTools",
    "LightGraphs",
    "LinearAlgebra",
    "NLopt",
    "OnlineStats",
    "Optim",
    "PGFPlots",
    "Parameters",
    "PlotlyJS",
    "Plots",
    "Polynomials",
    "Primes",
    "Printf",
    "QuadGK",
    "Random",
    "Revise",
    "Sobol",
    "SpecialFunctions",
    "Statistics",
    "StatsBase",
    "SymEngine",
    "TikzPictures",
    "TreeView",
    "WGLMakie",
    "Weave",
    "Zygote"
]

Pkg.add(dependencies)

Pkg.add(Pkg.PackageSpec(name="Vec", url="https://github.com/sisl/Vec.jl.git"))
