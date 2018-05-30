function f_mu = direct_interaction(mu,lambda,alpha) % one mu multiple lambda

    %f_mu = zeros(size(mu));
    sum = 0;
    for j= 1:length(lambda)
            sum = sum + (alpha(j) /(mu - lambda(j)));
    end
    f_mu = sum;
end

