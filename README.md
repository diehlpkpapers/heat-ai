# Evaluating AI-generated code for C++, Fortran, Go, Java, Julia, Matlab, Python, R, and Rust
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15400128.svg)](https://doi.org/10.5281/zenodo.15400128)

This study evaluates the capabilities of ChatGPT versions 3.5 and 4 in generating code across a diverse range of programming languages. Our objective is to assess the effectiveness of these AI models for generating scientific programs. To this end, we asked ChatGPT to generate three distinct codes: a simple numerical integration, a conjugate gradient solver, and a parallel 1D stencil-based heat equation solver. The focus of our analysis was on the compilation, runtime performance, and accuracy of the codes. While both versions of ChatGPT successfully created codes that compiled and ran (with some help), some languages were easier for the AI to use than others (possibly because of the size of the training sets used). Parallel codes -- even the simple example we chose to study here -- also difficult for the AI to generate correctly. 

## Publications

* [Preprint](https://arxiv.org/abs/2405.13101): Diehl P, Nader N, Brandt S, Kaiser H. Evaluating AI-generated code for C++, Fortran, Go, Java, Julia, Matlab, Python, R, and Rust. arXiv preprint arXiv:2405.13101. 2024 May 21.
