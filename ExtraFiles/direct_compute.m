function f_mu = direct_compute(mu,lambda,alpha)

    f_mu = zeros(length(mu),1);
    %sum = 0;
    for i = 1:length(mu)
        sum = 0;
        for j= 1:length(lambda)
            sum = sum + (alpha(j) /(mu(i) - lambda(j)));
        end
        f_mu(i) = sum;
    end
    %f_mu = sum;
end
