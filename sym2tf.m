
function Gs = sym2tf(Gss)
    syms s;
    [num,den] = numden(Gss);
    num = double(coeffs(num,s,"all"));
    den = double(coeffs(den,s,"all"));
    disp(num)
    disp(den)
    Gs = tf(num,den);
end