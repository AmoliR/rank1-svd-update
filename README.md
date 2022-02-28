[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/AmoliR/rank1-svd-update/blob/master/LICENSE) 
# Rank-1 Singular Value Decomposition Updating Algorithm
This MATLAB library implements algorithm for updating Singular Value Decomposition (SVD) for rank-1 perturbed matrix using Fast Multipole Method (FMM) in ![Equation](https://latex.codecogs.com/gif.latex?%5Cinline%20%5Cbg_black%20O%28n%5E2%20%5C%20%5Ctext%7Blog%7D%28%5Cfrac%7B1%7D%7B%5Cepsilon%7D%29%29)  time, where ![Equation](https://latex.codecogs.com/gif.latex?%5Cinline%20%5Cbg_black%20%5Cepsilon) is the precision of computation. Detailed explaination of the algorithm can be found in this [paper](https://arxiv.org/abs/1707.08369).
## Running the tests
Run **randomTestData.m** to define and generate random 1) Base matrix and 2) Rank-one update to the base matrix. **randomTestData.m** passes the generated base matrix to the function **testSVDUFMM.m** that computes updated singular values and vectors for the updated base matrix.
## Citation
If you use this package for your work, please cite the corresponding [paper](https://arxiv.org/abs/1707.08369)
as: 

**Gandhi, Ratnik, and Amoli Rajgor. "Updating Singular Value Decomposition for Rank One Matrix Perturbation." arXiv preprint arXiv:1707.08369 (2017)**

or as BibTeX format:
```
@article{DBLP:journals/corr/GandhiR17,
  author    = {Ratnik Gandhi and
               Amoli Rajgor},
  title     = {Updating Singular Value Decomposition for Rank One Matrix Perturbation},
  journal   = {CoRR},
  volume    = {abs/1707.08369},
  year      = {2017},
  url       = {http://arxiv.org/abs/1707.08369},
  archivePrefix = {arXiv},
  eprint    = {1707.08369},
  timestamp = {Sat, 05 Aug 2017 14:55:59 +0200},
  biburl    = {https://dblp.org/rec/bib/journals/corr/GandhiR17},
  bibsource = {dblp computer science bibliography, https://dblp.org}
```
