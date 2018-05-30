
%% FUNCTION FOR UPDATING CONSECUTIVE RANK ONE UPDATES
%function [U_td,V_td,mu,muv,time] = rankOneUpdate(U,V,a1,a2,lambda1,lambdav,rho1,rho3)
function [U_td,V_td,mu,muv] = rankOneUpdate(U,V,a1,a2,lambda1,lambdav,rho1,rho3,p)

a_bar = U' * a1;
a_barv = V' * a2;

%diag(D_td) = mu
% Eigenvalue update 
% mu = eigenValues(lambda1,rho1,a_bar);
% muv = eigenValues(lambdav,rho3,a_barv);

%% DIRECT COMPPUTE EIGENVALUES

mu = eig((U * diag(lambda1) * U')+(rho1*(a1*a1')));
muv = eig((V * diag(lambdav) * V')+(rho3*(a2*a2')));

%sort mu values
% if ~issorted(mu1)
%     mu1 = sort(diag(mu1),'descend');
% end
% if ~issorted(mu1)
%     muv1 = sort(diag(muv1),'descend');
% end
%%

% Update left eigenvectors
[C,U1] = vectorUpdate(lambda1,mu,a_bar,U);
[Cv,V1] = vectorUpdate(lambdav,muv,a_barv,V);

% U2d = U1 * C; %check direct
% Utd = scaleU(a_bar,C,U2d)

% Matrix vector product using FMM
% tic;
U2 = trummers(U1,lambda1,mu,p);
U_td = scaleU(a_bar,C,U2);
% time = toc;
V2 = trummers(V1,lambdav,muv,p);

V_td = scaleU(a_barv,Cv,V2);

%U_td = FAST(a_bar_Mat,lambda,mu,C,U);
%V_td = FAST(a_bar_Matv,lambdav,muv,Cv,V);
end