# Algorithms for Optimization Jupyter Notebooks

This repository contains supplemental Jupyter notebooks to accompany [Algorithms for Optimization](http://mitpress.mit.edu/books/algorithms-optimization) by Mykel Kochenderfer and Tim Wheeler.
These notebooks were generated from the Algorithms for Optimization source code.
We provide these notebooks to aid with the development of lectures and understanding the material, with the hope that you find it useful.

## Installation
All dependencies are installed using `Julia 1.8`.

[Julia can be installed here](https://julialang.org/downloads/)
or highly recommended [Juliaup - Julia version manager](https://github.com/JuliaLang/juliaup)

### Prerequisites
#### PGFPLots
Rendering of some notebooks is managed by [PGFPlots.jl](https://github.com/JuliaTeX/PGFPlots.jl).
Please see [their documentation](https://nbviewer.jupyter.org/github/JuliaTeX/PGFPlots.jl/blob/master/doc/PGFPlots.ipynb) for important installation instructions.
```bash
# On Ubuntu
sudo apt install texlive textlive-luatex textlive-pictures texlive-latex-extra latexmk
```

#### Makie
`WGLMakie` should work, but `GLMakie` on Linux may face issue with incompatible `libstdc++.so.6`. Potential fix for this issue is to replace the `libstdc++.so.6` shipped with Julia with the system version ([See issue details](https://github.com/JuliaLang/julia/pull/46976))
```bash
# Either remove or use symlink
ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ~/.julia/juliaup/julia-1.8.2+0.x64/lib/julia/libstdc++.so.6
```

### Install dependencies
Once the repo is cloned, one can set up the required packages from the terminal

```bash
# Initialize project. All dependencies are installed
julia --project=. -e 'using Pkg; pkg"instantiate"'
```

## Running
Recommend using VSCode with Julia plugin.

**Note**: Running notebook in VSCode doesn't require [IJulia](https://github.com/JuliaLang/IJulia.jl) to be installed.