# Data Assimilation in Nonlinear Fluid Flow — 4 Beamer presentations

This is an Overleaf-ready project with four presentation modules. Each presentation contains 25–30 slides and is self-contained: a presentation may compare with methods introduced earlier, but it does not preview methods that have not yet been introduced.

## Presentation files

All presentation sources and compiled PDFs are in `decks/`:

1. **`moduls_1_kalman_filter.tex`** — data-assimilation foundations, Burgers flow, classical KF derivation, exact linear–Gaussian theorem/proof, nonlinear model mismatch, full KF output map, absolute-error map with colorbar, and explicit KF tradeoff tables.
2. **`moduls_2_enkf.tex`** — EnKF derivation, convergence theorem/proof, finite-ensemble rank/sampling issues, localization/inflation, nonlinear output/error maps, KF–EnKF comparison, and accuracy-versus-compute tradeoffs.
3. **`moduls_3_nudging.tex`** — continuous/discrete nudging, feedback-observer interpretation, stability theorem/proof, output/error maps, and a deliberately clear comparison showing similar error to a small EnKF with far fewer nonlinear forecasts.
4. **`moduls_4_neural_surrogate.tex`** — a NumPy-only neural forecast surrogate, training theory, hybrid NN+nudging error bound/proof, output/error maps, accuracy penalty, and runtime scaling as the domain grows.

## Use in Overleaf

Upload the complete project ZIP. In Overleaf, set any file under `decks/` as the Main document and compile with pdfLaTeX.

No shell escape, `minted`, PythonTeX, or nonstandard Overleaf extension is needed. All plots are already generated.

## Reproduce the synthetic experiment locally

Only NumPy and Matplotlib are required:

```bash
python -m pip install -r requirements.txt
python code/run_all.py
```

The experiment uses the 1-D viscous Burgers equation

```text
u_t + u u_x = nu u_xx
```

with `N=32`, `nu=0.01`, assimilation interval `0.10`, 80 assimilation cycles, sensors every 8th grid point, and observation-noise standard deviation `0.08`.

The scripts regenerate:

- full space–time state maps,
- absolute-error maps with colorbars,
- final-state comparisons,
- RMSE curves,
- ensemble-size accuracy/runtime sweeps,
- nudging-gain sensitivity,
- neural training loss,
- neural-versus-PDE scaling plots,
- `data/tutorial_data.npz` and generated LaTeX metric macros.

## Current deterministic synthetic results

| Method | Mean RMSE | Main online forecast work |
|---|---:|---|
| Frozen-linear KF | 0.647 | one cheap linear forecast |
| EnKF, M=10 | 0.032 | 10 nonlinear forecasts/cycle |
| EnKF, M=40 | 0.012 | 40 nonlinear forecasts/cycle |
| PDE + nudging | 0.035 | 1 nonlinear forecast/cycle |
| NN + nudging | 0.054 | 1 neural-map call/cycle |

The third presentation uses the `M=10` EnKF comparison to make the accuracy–cost point explicit: nudging has nearly the same mean RMSE (`0.035` versus `0.032`) while using one nonlinear forecast instead of ten. The `M=40` EnKF remains the higher-accuracy but higher-cost reference.

The neural presentation separately compares PDE+nudge (`0.035`) with NN+nudge (`0.054`) and then shows why the direct neural map becomes relatively faster as the grid is refined. The large-grid timing test is a compute-scaling benchmark, not a claim of automatic cross-resolution accuracy.

## Directory structure

```text
.
├── common.tex
├── compile_all.sh
├── requirements.txt
├── README.md
├── decks/
│   ├── moduls_1_kalman_filter.tex
│   ├── moduls_2_enkf.tex
│   ├── moduls_3_nudging.tex
│   └── moduls_4_neural_surrogate.tex
├── code/
│   ├── burgers.py
│   ├── da_methods.py
│   ├── surrogate.py
│   ├── generate_results.py
│   └── run_all.py
├── data/
│   ├── metrics.json
│   ├── metrics.tex
│   ├── tutorial_data.npz
│   ├── ensemble_sweep.csv
│   ├── nudging_gain_sweep.csv
│   └── scaling_benchmark.csv
└── figures/
    └── generated PNG figures used by the presentations
```

## Compile all presentations locally

From the project root:

```bash
./compile_all.sh
```

The PDFs are written into `decks/` beside their `.tex` sources.
