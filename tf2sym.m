function Gss= tf2sym(Gs)
    num=Gs.Numerator{:};
    den=Gs.Denominator{:};
    n = length(den)-1;

    syms s;
    ns=0;
    ds=0;
    for i=1:length(den)
        ns = ns+num(i)*s^(n-i+1);
        ds = ds+den(i)*s^(n-i+1);
    end
    Gss = ns/ds;
end