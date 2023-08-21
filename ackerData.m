%% Ömer Faruk Yıldız - 040200546

function [Phi,pdA]=ackerData(A,B,poles)
    
    syms s;
    n = length(poles);
    
    Phi = zeros(length(B),n);
    pds = 1;
    for i = 1:n
            Phi(:, i) = double(A^(i-1) * B);
            pds = (s-poles(i))*pds;
    end
    
    coef = coeffs(pds,s,"All");
    pdA = 0;
    for i = 0:n
        pdA = pdA + double(A^(n-i)*coef(i+1)*eye(n));
    end
    
end