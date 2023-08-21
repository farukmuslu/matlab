syms x(k)  z;
assume(k>=0 & in(k,'integer'));


f = x(k+2) - x(k+1) - 0.25*x(k) - u(k+2);

fZT = ztrans(f,k,z);
syms xZT ;
fZT = subs(fZT,ztrans(x(k),k,z),xZT);
xZT = solve(fZT,xZT);
xSol = iztrans(xZT,z,k);
xSol = simplify(xSol);
xSol = subs(xSol,[x(0) x(1)],[1 2]);


function u_k = u(k)
    if k>=0
     u_k = 1;
    else
     u_k = 0;
    end
 end