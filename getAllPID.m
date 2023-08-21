function info=getAllPID(Gs,pole)   
syms s;
[NUM,DEN] = tfdata(Gs);
num = poly2sym(cell2mat(NUM),s);
den = poly2sym(cell2mat(DEN),s);
Gss = num/den;

syms kd kp ki real;
Fss=(kd*s^2+kp*s+ki)/s;
Tss=(Fss*Gss)/(Fss*Gss+1);
[pzs,pcs]=numden(Tss);
coef=coeffs(pcs,s,"All");
coef=coef/coef(1);

pds=expand((s-pole)*(s-conj(pole)));
pcs_degree = length(coef)-1;
pes_degree = pcs_degree-2;
x = sym('x',[1,pes_degree]);
x_matrix = [1 x];
pes_sym = sym(x_matrix)*s.^(pes_degree:-1:0)';
pes = subs(simplify(pes_sym), conj(s), s);

prob=coef==coeffs(pds*pes,s,"All");

sol=solve(prob,[kd,kp,x]);
solArray = struct2array(sol);
FilteredArray = solArray(3:end);

pes2 = subs(pes, x, FilteredArray);
pzs2 = subs(pzs,[kd kp],[sol.kd sol.kp]);
kd2=sol.kd;
kp2=sol.kp;       
info=struct("kd",kd2,"kp",kp2,"pes",pes2,"pzs",pzs2);
end



