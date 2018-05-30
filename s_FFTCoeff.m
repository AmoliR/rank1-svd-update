%% FUNCTION TO FIND COEEFICIENTS OF A POLYNOMIAL of form $$ \prod\limits_{j=1}^{n} (\lambda - x) $$ USING FFT 

%Any number greater than the degree of polynomial is called its degree
%bound for example for  a polynomial of degree 2 the degree bound is
%3,4,5.. i.e anything > 2. When we mulyiply two polynomial of degree bound
%n each the resultant polynomial is of degree bound n+n = 2n. Thus while
%finding coeff of resultant polynomial of the polynomial multiplication we
%append zeros to the coeff representation of polynomials to make the vector
%length 2n. For example if p1 = (x-1) and p2 = (x-2) [1,-2] then their 
%coeff represenattion is p1 = [1,-1] and [1,-2](H to L) with degree bound 2 
%and 2 resp. p3 = p1 * p2 = x^2 - 3*x +2. i.e [1,-3,2] and db=3,4..
% So for FFT make db of p1 = 2n = 2*2 = 4. so p1 = [1,-1,0,0] and 
% p2 = [1,-2,0,0] the resultant polynomial will have degree bound n+n = 2n and
% degree n+n-1. So if we multiply the polynomial of degree 3 and degree 2
% the resultant polynomial will be of degree 3+2-1 = 4 and degree bound 3+2=5. 

%% 
function p1 = s_FFTCoeff(lambda)
x = sym('x');
p1 = (lambda(1) - x);
p1 = sym2poly(p1);
for i = 1:(length(lambda)-1)
    p2 = lambda(i+1) - x;
    %cp1 = sym2poly(p1);
    cp1 = p1;
    cp2 = sym2poly(p2);
    dbp1 = length(cp1); % Degree bound of first polynomial 
    dbp2 = length(cp2);
    dbp3 = dbp1 + dbp2; % Degree bound of resulting polynomial
    if dbp3 % 2 == 0 %degree bound is multiple of 2
        cp1(end+dbp2)=0;
        cp2(end+dbp1)=0;
    else
        cp1(end+(dbp2+1))=0; % make it multiple of two
        cp2(end+(dbp1+1))=0;
    end
    xdft = fft(cp1);
    ydft = fft(cp2);
    z = ifft(xdft .* ydft);
    z = z(1:end-1); % Discard last element as it is zero
    %(because we had zero padded both vectors by an extra 0)
    %pz = vpa(poly2sym(z),5);
    % p1 = pz
    p1 = z;
end

