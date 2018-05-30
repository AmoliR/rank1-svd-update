% FUNCTION FOR IMPLEMENTING ALGORITHM 1 (P. STANGE)
%--------------------------------------------------------------------------
% P. Stange, On the efficient update of the singular value decomposition,
% PAMM 8 (1) (2008) 10827–10828.
%--------------------------------------------------------------------------

function U_td = s_FAST(a_bar,lambda,mu,C,U1)

% Polynomial Interpolation and FFT: (1.) Find coeff of g(x) using FFT
%This step is common to all
a_bar_Mat = diag(a_bar); % diagonal matrix of a_bar

gx = s_FFTCoeff(lambda); %resultant polynomial is truncated to 5 sig digits. 

%% (2.) Find coefficients of g'(x)
%This step is common to all
gxd = diff(poly2sym(gx));

%% (3.) Evaluate $$ g(\lambda_i), \ g'(\lambda_i) $$ and $$ g'(\mu_i) $$
%for mu_1 and u1
%This step is common to all
%gl = polyval(sym2poly(gx),lambda);
gdl = polyval(sym2poly(gxd),lambda);

%% (4.) Compute $$ h_j = u_jg'(\lambda_j) $$
% Breaking U * C_td = U * a_bar_Mat * C * diag(C_hat_Norm)
% NOTE :: This step is NOT common to all. different for each row of U1

% U1 = U * a_bar_Mat;
%U2 = U1 * C; % HERE THE LOGIC OF CAUCHY MATRIX-VECTOR PRODUCT APPLIES
% MULTIPLY ROW OF U1 AND COLUMN OF C CAUCHY MATRIX WHERE LAMBDA CHANGES MU
% REMAINS SAME.
v = zeros(size(U1,1),size(C,2));

for i = 1:size(U1,1)
    h = U1(i,:)' .* gdl;
    hx = s_interpolate(lambda,h); % (5.)Find interpolation polynomial for(lambda_j,h_j)
    for j = 1:size(C,2)
        v(i,j) = s_f(mu(j),hx,gx); % (6.)Find function value f i.e. v
    end
end

%% Scale U2 to get $$ \tilde{U} $$
%U_td = scale(v); %not needed

C_hat = a_bar_Mat * C;
%U_td = scale(a_bar_Mat,C,v);
C_hat_Norm = [1,size(C_hat,2)];
for i = 1:size(C_hat,2)

    C_hat_Norm(i) = 1/norm(C_hat(:,i));
end
 U_td = v * diag(C_hat_Norm);
end
