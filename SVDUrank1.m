%% IMPLEMENTATION OF SVD UPDATING ALGORITHM FOR RANK-1 
%% PERTURBED MATRICES(USING FFM) 
%--------------------------------------------------------------------------
% Gandhi, Ratnik, and Amoli Rajgor. "Updating Singular Value Decomposition
% for Rank One Matrix Perturbation." arXiv preprint arXiv:1707.08369 (2017)
%--------------------------------------------------------------------------
% Author:    Amoli Rajgor
% Created:   4.07.2016
%--------------------------------------------------------------------------

% Functions returning time, error and updated vectors
function [time,U_,S_,V_] = SVDUrank1(Ai,a_,b_,p)

% -- other options
% function [err,time] = SVDUrank1(Ai,a_,b_,p)
% function time = SVDUrank1(Ai,a_,b_)


%% Define Original Matrix $$ A_{m \times n} $$
A = Ai;
a = a_;
b = b_;
A_ = A + (a * b'); % New updated matrix

%% Compute known SVD of the original matrix $$ A = U \Sigma V^T $$
[U,S,V] = svd(A); % Known decomposition
%% %% Represent $$ A^TA $$ as sum of three rank-1 updates 
tic;
b_td = U * S * V' * b; 
a_td = V * S' * U' * a; 

beta_1 = b' * b;
alpha_1 = a' * a;

%A_A_T = (U * (S * S') * U') + (b_td * a' + a * b_td') + (beta * (a * a'));
%A_T_A = (V * (S' * S) * V') + (a_td * b' + b * a_td') + (alpha * (b * b'));

%% Modify the sum of three rank-1 updates to sum of two rank one updates
D = S * S';
Dv = S' * S;

[rho1,rho2,a1,b1] = symmetricChar(beta_1,a,b_td);
[rho3,rho4,a2,b2] = symmetricChar(alpha_1,b,a_td);

%% Get updated vectors 
lambda1 = diag(D); 
lambdav = diag(Dv); 

% [U_td,V_td,mu,muv,time] = rankOneUpdate(U,V,a1,a2,lambda1,lambdav,rho1,rho3);
% 
% [U_,V_,mu_,muv_,time2] = rankOneUpdate(U_td,V_td,b1,b2,mu,muv,rho2,rho4);

[U_td,V_td,mu,muv] = rankOneUpdate(U,V,a1,a2,lambda1,lambdav,rho1,rho3,p);

[U_,V_,mu_,muv_] = rankOneUpdate(U_td,V_td,b1,b2,mu,muv,rho2,rho4,p);

time = toc;
%% VERIFY RESULTS

 [U_d,S_d,V_d] = svd(A_); % Find svd of updated matrix directly 
%-------------------------------------------------------------------------
% NOTE:    VECTORS VALUES ARE NOT EXACT AND SIGNS ARE DIFFERENT SO ABS IS 
%          USED WHILE COMPARING ALSO THE RESULTS ARE COMPARED WITH 0.0001
%          TOLERANCE.
%-------------------------------------------------------------------------
 
% %Compare the results.
% equalMat(abs(U_d),abs(U_))  
% equalMat(diag(S_d),sqrt(mu_))
% equalMat(abs(V_d),abs(V_))

%Compute error
err = abs(A_ - (U_*diag(sqrt(mu_))*V_'))/(max(diag(S_d)));
err = max(reshape(err,[(size(err,1)*size(err,2)),1]));
S_ = diag(sqrt(mu_))
end
