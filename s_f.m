%% FUNCTION FOR FINDING F(X)
function v = s_f(mu,h,g)
hm = polyval(h,mu);
gm = polyval(g,mu);
v = hm ./gm;
end

% try
% h(~isfinite(h))=0;
% g(~isfinite(g))=0;
% h(isnan(h))=0;
% g(isnan(g))=0;
% hm = polyval(sym2poly(h),mu);
% gm = polyval(sym2poly(g),mu);
% v = hm ./gm;
%  
% catch
%   disp('that was not a polynomial')
% end