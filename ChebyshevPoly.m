function u = ChebyshevPoly(t,p)
syms x
%x = sym('x');
u = {1,p}; %cell array
%u{1,1} = 1;
for j = 1:p
    mul = 1;
    for k = 1:p
        if k ~= j
            mul = mul * ((x - double(t(k)))/double((t(j) - t(k))));
            %u{1,j} =  u{1,(j-1)} * u{1,j}
        end
    end
    %u{1,j} = vpa(expand(mul),5); % 5 significant digit
    u{1,j} = sym2poly(mul);
end

end