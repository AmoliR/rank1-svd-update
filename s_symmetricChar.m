%% OBTAIN a1,b1,a2,b2,rho1,..,rho4.

function [rho1,rho2,a1,b1] = s_symmetricChar(beta,a,b_td)
Beta_Mat = [beta,1;1,0];
[Q,rho] = schur(Beta_Mat); % eigenvalues are in increasing order
%-------------------------------------------------------------------------
% CHECK :: isequal(Beta_Mat,(Q*rho*Q')) or equalMat(Beta_Mat,(Q*rho*Q')) 
%-------------------------------------------------------------------------

Dia_rho = diag(rho); % sort eigenvalues in decending order
rho = diag(Dia_rho(end:-1:1)); 
Q = Q(:,end:-1:1); % sort eigenvector in decending order
a1b1 = [a,b_td] * Q;
a1 = a1b1(:,1);
b1 = a1b1(:,2);
rho1 = rho(1,1);
rho2 = rho(2,2);
end