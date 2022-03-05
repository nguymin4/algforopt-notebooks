# Algorithms for Optimization Jupyter Notebooks

This repository contains supplemental Jupyter notebooks to accompany [Algorithms for Optimization](http://mitpress.mit.edu/books/algorithms-optimization) by Mykel Kochenderfer and Tim Wheeler.
These notebooks were generated from the Algorithms for Optimization source code.
We provide these notebooks to aid with the development of lectures and understanding the material, with the hope that you find it useful.

## Installation
All notebooks have Julia 1.0.1 kernels.
[Julia can be installed here](https://julialang.org/downloads/)
or highly recommended [Juliaup - Julia version manager](https://github.com/JuliaLang/juliaup)

Rendering is managed by [PGFPlots.jl](https://github.com/JuliaTeX/PGFPlots.jl).
Please see [their documentation](https://nbviewer.jupyter.org/github/JuliaTeX/PGFPlots.jl/blob/master/doc/PGFPlots.ipynb) for important installation instructions.
```bash
# On Ubuntu
sudo apt install texlive textlive-luatex textlive-pictures texlive-latex-extra latexmk
```

Once the repo is cloned, one can set up the required packages from the terminal

```bash
# Initialize project. All dependencies are installed
julia --project=. -e 'using Pkg; pkg"instantiate"'
```

Julia notebooks are supported by [IJulia](https://github.com/JuliaLang/IJulia.jl) and they can be opened by the jupyter lab or VSCode.

