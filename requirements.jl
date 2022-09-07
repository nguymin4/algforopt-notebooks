import Pkg

Pkg.add(Pkg.PackageSpec(name="Vec", url="https://github.com/sisl/Vec.jl.git"))

dependencies = [
  "ColorSchemes",
  "Colors",
  "DataStructures",
  "Discretizers",
  "Distributions",
  "ExprRules",
  "ForwardDiff",
  "ImageMagick",
  "IterTools",
  "LightGraphs",
  "LinearAlgebra",
  "NLopt",
  "OnlineStats",
  "Optim",
  "PGFPlots",
  "Parameters",
  "Plots",
  "PlotlyJS",
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
  "Vec",
  "Weave",
  "Zygote"
]


Pkg.add(dependencies)
