%% IMPLEMENTATION OF RANK-ONE UPDATE SVD THROUGH FFT AND ITERPOLATION 
%% (PETER STANGE, 2008)
%--------------------------------------------------------------------------
% P. Stange, On the efficient update of the singular value decomposition,
% PAMM 8 (1) (2008) 10827–10828.
%--------------------------------------------------------------------------

% Returns error,time & updated vectors
function [time_s,U_, S_,V_] = s_SVDUrank1(Ai,a_,b_)

% -- other options
% Returns time and error
% function [err_s,time_s] = s_SVDUrank1(Ai,a_,b_) 
% function time_s = s_SVDUrank1(Ai,a_,b_) % returns run time 

%% Define Original Matrix $$ A_{m \times n} $$

A = Ai;
a = a_;
b = b_;
A_ = A + (a * b'); % New updated matrix
%% Compute known SVD of the original matrix $$ A = U \Sigma V^T $$

[U,S,V] = svd(A); % Known decomposition
%% %% Represent $$ A^TA $$ as sum of three rank-1 updates 
tic;
b_td = U * S * V' * (b); 
a_td = V * S' * U' * (a); 

beta = b' * b;
alpha = a' * a;

%A_A_T = (U * (S * S') * U') + (b_td * a' + a * b_td') + (beta * (a * a'));
%A_T_A = (V * (S' * S) * V') + (a_td * b' + b * a_td') + (alpha * (b * b'));

%% Modify the sum of three rank-1 updates to sum of two rank one updates
D = S * S';
Dv = S' * S;

[rho1,rho2,a1,b1] = s_symmetricChar(beta,a,b_td);
[rho3,rho4,a2,b2] = s_symmetricChar(alpha,b,a_td);

%% Get updated vectors 
lambda = diag(D); 
lambdav = diag(Dv); 

% [U_td,V_td,mu,muv,time_s] = s_rankOneUpdate(U,V,a1,a2,lambda,lambdav,rho1,rho3);
% [U_,V_,mu_,muv_,time_s2] = s_rankOneUpdate(U_td,V_td,b1,b2,mu,muv,rho2,rho4);

[U_td,V_td,mu,muv] = s_rankOneUpdate(U,V,a1,a2,lambda,lambdav,rho1,rho3);
[U_,V_,mu_,muv_] = s_rankOneUpdate(U_td,V_td,b1,b2,mu,muv,rho2,rho4);

time_s = toc;

%% VERIFY RESULTS

 [U_d,S_d,V_d] = svd(A_); % Find svd of updated matrix directly 

%-------------------------------------------------------------------------
% NOTE:    VECTORS VALUES ARE NOT EXACT AND SIGNS ARE DIFFERENT SO ABS IS 
%          USED WHILE COMPARING ALSO THE RESULTS ARE COMPARED WITH 0.0001
%          TOLERANCE.
%-------------------------------------------------------------------------
% Compare the results.
% equalMat(abs(U_d),abs(U_)) 
% equalMat(diag(S_d),sqrt(mu_)) 
% equalMat(abs(V_d),abs(V_))

% Compute error
err_s = abs(A_ - (U_*diag(sqrt(mu_))*V_'))/(max(diag(S_d)));
err_s = max(reshape(err_s,[(size(err_s,1)*size(err_s,2)),1]));

% Convert to singular values
S_ = diag(sqrt(mu_));
end