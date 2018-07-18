%% FUNCTION TO FIND COEEFICIENTS OF A POLYNOMIAL of form $$ \prod\limits_{j=1}^{n} (\lambda - x) $$ USING FFT %% 

function p1 = s_FFTCoeff(lambda)
x = sym('x');
p1 = (lambda(1) - x);
p1 = sym2poly(p1);
for i = 1:(length(lambda)-1)
    p2 = lambda(i+1) - x;
    %cp1 = sym2poly(p1);
    cp1 = p1;
    cp2 = sym2poly(p2);
    dbp1 = length(cp1); % Degree bound of first polynomial 
    dbp2 = length(cp2);
    dbp3 = dbp1 + dbp2; % Degree bound of resulting polynomial
    if dbp3 % 2 == 0 %degree bound is multiple of 2
        cp1(end+dbp2)=0;
        cp2(end+dbp1)=0;
    else
        cp1(end+(dbp2+1))=0; % make it multiple of two
        cp2(end+(dbp1+1))=0;
    end
    xdft = fft(cp1);
    ydft = fft(cp2);
    z = ifft(xdft .* ydft);
    z = z(1:end-1); % Discard last element as it is zero
    %(because we had zero padded both vectors by an extra 0)
    %pz = vpa(poly2sym(z),5);
    % p1 = pz
    p1 = z;
end

