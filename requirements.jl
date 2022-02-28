using Pkg

Pkg.add(PackageSpec(url="https://github.com/sisl/Vec.jl.git"))

dependencies = [
  "Colors",
  "ColorSchemes",
  "DataStructures",
  "Discretizers",
  "Distributions",
  "ExprRules",
  "ForwardDiff",
  "IterTools",
  "LightGraphs",
  "LinearAlgebra",
  "NLopt",
  "ImageMagick",
  "OnlineStats",
  "Optim",
  "Parameters",
  "PGFPlots",
  "Polynomials",
  "Primes",
  "Printf",
  "QuadGK",
  "Random",
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