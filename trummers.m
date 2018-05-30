%%CAUCHY MATRIX-VECTOR PRODUCT: TRUMMER'S PROBLEM
function f_value = trummers(U1,lambda_,mu_,p)
f_value = zeros(size(U1,1),length(mu_));

%problem size
N = length(lambda_);     

%Choose precisiong epsilon e such that 0 < e < 1, e is positive.
% as we want to keep p =10 we choose E = 5^-10 / choose 5^-16.
%E = 5^-20;  

% p = -log_5(E) base = 5 order of ploynomial
%p = ceil(-log(E)/log(5));    

% minimum points at finest level
s = 2*p;  %we have not chosen it as 2p

%nlevs = ceil(log(N/s)/log(2));

%maximum division permitted
%max_level_ = 8;

%chebyshev nodes
t = chebyshevNodes(p);

%chebyshev polynomials
u = ChebyshevPoly(t, p);

ML = zeros(p,p);
MR = zeros(p,p);
SL = zeros(p,p);
SR = zeros(p,p);
T1 = zeros(p,p);
T2 = zeros(p,p);
T3 = zeros(p,p);
T4 = zeros(p,p);
[ML,MR,SL,SR,T1,T2,T3,T4] = EvaluateM_S_T(ML,MR,SL,SR,T1,T2,T3,T4,t,u,p);

%% call fmm for row column multiplication
for i = 1:size(U1,1) %rows
    for j = 1:length(mu_) %columns
        f_value(i,j) = FMM2(-U1(i,:),lambda_,mu_(j),p,s,t,u,ML,MR,SL,SR,T1,T2,T3,T4);
    end
end

end