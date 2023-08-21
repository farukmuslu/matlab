clc;clear;
syms  s;

Gs = s^3/(s^3-2*s^2+1.25*s-0.25); 
%Gs = 2/(s*(s+3)^2);
[num, den]=numden(Gs);
num_coeff=double(coeffs(num,s,"All"));
den_coeff=double(coeffs(den,s,"All"));
[r,p,k]=residue(num_coeff,den_coeff);
