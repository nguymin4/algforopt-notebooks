using Pkg

Pkg.add(PackageSpec(url="https://github.com/sisl/Vec.jl.git"))

dependencies = [
  "ColorSchemes",
  "Colors",
  "DataStructures",
  "Discretizers",
  "Distributions",
  "ExprRules",
  "ForwardDiff",
  "IJulia",
  "ImageMagick",
  "IterTools",
  "LightGraphs",
  "LinearAlgebra",
  "NLopt",
  "OnlineStats",
  "Optim",
  "PGFPlots",
  "Parameters",
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
