%% FUNCTION FOR UPDATING EIGENVECTORS

function U_td = scaleU(a_bar,C,U2)

C_hat = diag(a_bar) * C;
C_hat_Norm = [1,size(C_hat,2)];
for i = 1:size(C_hat,2)

    C_hat_Norm(i) = 1/norm(C_hat(:,i));
end
 U_td = U2 * diag(C_hat_Norm);
end
