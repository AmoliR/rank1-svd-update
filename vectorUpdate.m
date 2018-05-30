%% FUNCTION FOR UPDATING EIGENVECTORS

function [C,U1] = vectorUpdate(lambda_,mu_,a_bar,U)

C = zeros(length(lambda_),length(lambda_)); 
for lam_var = 1:length(lambda_)

  for mu_var = 1:length(lambda_) 
  
    C(lam_var,mu_var) = 1 / (lambda_(lam_var) - mu_(mu_var));
  end
end
U1 = U * diag(a_bar);
end
