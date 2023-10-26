# Wolfram

## Description

Wolfram is a software that displays the output of a one-dimensional cellular automaton, named after Stephen Wolfram, the creator of Mathematica. The software is written in Haskell. It is a command-line application.

## Installation

To install Wolfram, follow these steps:

1. Install stack from https://docs.haskellstack.org/en/stable/README/
2. Execute `make`
3. And use it, for example: `./wolfram --rule 110 --lines 20`

## Usage

Wolfram provides a variety arguments to customize the output. The following table describes the available arguments:

- `--rule` - The rule to use for the cellular automaton. Must be an integer between 0 and 255.
- `--lines` - The number of lines to output. Must be an integer greater than 0.
- `--start` - The starting configuration of the automaton. Must be a string of 0s and 1s.
- `--window` - The number of cells to display at once. Must be an integer greater than 0.
- `--move` - The number of cells to move the window after each step. Must be an integer greater than 0.

## Screenshots

![Screenshot 1](
https://raw.githubusercontent.com/NielsOuvrard/wolfram/main/wolfram%20--rule%20102%20--lines%2060%20--window%20125%20--start%200%20--move%200.png)

![Screenshot 2](
https://raw.githubusercontent.com/NielsOuvrard/wolfram/main/wolfram%20--rule%2090%20--lines%2060%20--window%20125%20--start%200%20--move%200.png)