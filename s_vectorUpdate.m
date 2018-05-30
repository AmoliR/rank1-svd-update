%% FUNCTION FOR UPDATING EIGENVECTORS

function [C,U1] = s_vectorUpdate(lambda,mu,a_bar,U)

C = zeros(length(lambda),length(lambda)); 
for lam_var = 1:length(lambda)

  for mu_var = 1:length(lambda) 
  
    C(lam_var,mu_var) = 1 / (lambda(lam_var) - mu(mu_var));
  end
  
end
U1 = U * diag(a_bar);
end
