%% GENERATE DATA FOR SVDU ALGORITHM
A = randi([1 9], 5, 5); 
a = randi([1 9], 5, 1);
b = randi([1 9], 5, 1);
p = 14; % machine precision

A_ = A + (a * b');
[U_d,S_d,V_d] = svd(A_); % Direct Compute SVD

%% FMM-SVDU
%--------------------------------------------------------------------------
% Gandhi, Ratnik, and Amoli Rajgor. "Updating Singular Value Decomposition
% for Rank One Matrix Perturbation." arXiv preprint arXiv:1707.08369 (2017)
%--------------------------------------------------------------------------
[time,U_,S_,V_] = testSVDUFMM(A,a,b,p) %FMM-SVDU