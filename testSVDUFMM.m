%% TEST CODE FOR SVDU ALGORITHM
function [time,U_,S_,V_] = testSVDUFMM(A,a,b,p)

%% SVDU (P.Stange 2008)
%--------------------------------------------------------------------------
% P. Stange, On the efficient update of the singular value decomposition,
% PAMM 8 (1) (2008) 10827–10828.
%--------------------------------------------------------------------------
% Returns time and updated matrix
[time_s,U_s,S_s,V_s] = s_SVDUrank1(A,a,b)%SVDU

%% FMM-SVDU
%--------------------------------------------------------------------------
% Gandhi, Ratnik, and Amoli Rajgor. "Updating Singular Value Decomposition
% for Rank One Matrix Perturbation." arXiv preprint arXiv:1707.08369 (2017)
%--------------------------------------------------------------------------
[time,U_,S_,V_] = SVDUrank1(A,a,b,p) %FMM-SVDU
end