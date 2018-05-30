clear;
%clc;
N = 5;
M = 5;
a = -1;
b = 1;
x = a + (b-a).*rand(N,1);
x0 = mean(x);
r = max(x-x0);
y = a + (b-a).*rand(M,1);
y0 = mean(y);
ry = max(y-y0);
alpha_k = ones(N,1);
f = zeros(M,1);
f1 = zeros(M,1);
f2 = zeros(M,1);
p = 50;
%chebyshev nodes
t = chebyshevNodes(p);

%chebyshev polynomials
u = ChebyshevPoly(t, p);
phi = zeros(p,1);
psi = zeros(p,1);

%% DIRECT
for i = 1:M
    sum = 0;
    for k = 1:N
        sum = sum + (alpha_k(k)/(y(i) - x(k)));   
    end
    f(i) = sum;
end
%% Approximation 1
for j = 1:p
    sum = 0;
    for k = 1:N
       sum = sum + ((alpha_k(k) * t(j))/(3*r - (t(j)*(x(k) - x0))));
    end
    phi(j) = sum;
end
for i = 1:M
    sum = 0;
    for j = 1:p
        sum = sum + (phi(j) *  (polyval(u{j},((3*r)/(y(i) - x0)))));
    end
    f1(i) = sum;
end

%% Approximation 2
for j = 1:p
    sum = 0;
    for k = 1:N
       sum = sum + (alpha_k(k) /((r*t(j)) - (x(k) - x0)));
    end
    psi(j) = sum;
end
for i = 1:M
    sum = 0;
    for j = 1:p
        sum = sum + (psi(j) *  (polyval(u{j},((y(i) - y0)/(ry)))));
    end
    f2(i) = sum;
end

final = [f,f1,f2]