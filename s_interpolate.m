%% FUNCTION FOR LAGRANGE INTERPOLATION

function polynomial = s_interpolate(lambda,h)
x = sym('x');

n = length(lambda);
polynomial = zeros(size(x));
for sum_var = 1:n
    div = ones(size(x));
    for div_var = [1:sum_var-1 sum_var+1:n]
        div = (x-lambda(div_var))./(lambda(sum_var)-lambda(div_var)).*div;
    end
    polynomial = polynomial + div*h(sum_var);
end
polynomial = sym2poly(polynomial);
%pretty(poly);
%poly = vpa(simplify(poly),5); %convert to 5 significant digits

% polynomial(~isfinite(polynomial))=0;
% polynomial(isnan(polynomial))=0;
end