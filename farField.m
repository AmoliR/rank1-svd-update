function phi = farField(phi,t,r,lambda_i,lambda_zero,alpha)

    for j = 1:length(t) % order p chebyshev nodes
        sum = 0;
        for k = 1:length(lambda_i) % for all the lambdas in the interval
            sum = sum + ((alpha(k)*t(j))/(3*r - (t(j)*(lambda_i(k) - lambda_zero))));
        end
        phi(j,1) = sum;
    end

end

