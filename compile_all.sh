#!/usr/bin/env sh
set -eu
for presentation in   moduls_1_kalman_filter   moduls_2_enkf   moduls_3_nudging   moduls_4_neural_surrogate
do
  pdflatex -interaction=nonstopmode -halt-on-error -output-directory=decks "decks/${presentation}.tex"
done
