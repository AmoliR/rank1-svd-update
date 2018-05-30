
%% FUNCTION FOR UPDATING CONSECUTIVE RANK ONE UPDATES
% function [U_td,V_td,mu,muv,time_s] = s_rankOneUpdate(U,V,a1,a2,lambda1,lambdav,rho1,rho3)
function [U_td,V_td,mu,muv] = s_rankOneUpdate(U,V,a1,a2,lambda1,lambdav,rho1,rho3)

% Diagonal Update
a_bar = U' * a1;
a_barv = V' * a2;

%diag(D_td) == mu

% Eigenvalue update
% mu = s_eigenValues(lambda,rho1,a_bar);
% muv = s_eigenValues(lambdav,rho3,a_barv);

%% DIRECT COMPPUTE EIGENVALUES

mu = eig((U * diag(lambda1) * U')+(rho1*(a1*a1')));
muv = eig((V * diag(lambdav) * V')+(rho3*(a2*a2')));

% mu1 = mu1(end:-1:1);
% muv1 = muv1(end:-1:1);

%sort mu values
% if ~issorted(mu1)
%     mu1 = sort(diag(mu1),'descend');
% end
% if ~issorted(mu1)
%     muv1 = sort(diag(muv1),'descend');
% end
%%
% Update left eigenvectors
[C,U1] = s_vectorUpdate(lambda1,mu,a_bar,U);
[Cv,V1] = s_vectorUpdate(lambdav,muv,a_barv,V);

% Polynomial Interpolation and FFT
%tic;
U_td = s_FAST(a_bar,lambda1,mu,C,U1);
%time_s = toc;
V_td = s_FAST(a_barv,lambdav,muv,Cv,V1);
end