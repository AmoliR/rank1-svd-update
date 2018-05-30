%% FUNCTION FOR UPDATING EIGENVALUES (GOLUB)

function mu = eigenValues(lambda1,rho1,a_bar)

    if(length(find(~real(a_bar))) == length(a_bar)) % all elements zero
         mu = lambda1;
    else
    
        syms x
        eqn = 1 + (rho1 * sum((a_bar.^2) ./ (lambda1 - x)));
        mu1 = sort(double(solve(eqn)),'descend');
        
        if(~isempty(find(~real(a_bar)))) %a_bar has zero
            mu = lambda1;
            non_zero_index = find(a_bar); % non - zero index
            j = 1;
            for i = 1:length(non_zero_index)
                mu(non_zero_index(i)) = mu1(j);
                j = j + 1;
            end
        else
        
            mu = mu1;
        end
    end
%     sum_var = 0;
%     for i = 1:length(lambda1)
%         sum_var = sum_var + ((a_bar(i) * a_bar(i))/(lambda1(i) - x)); 
%     end
%     eqn1 = 1 + (rho1 * sum_var); 
%     mu = sort(double(solve(eqn1)),'descend');
end