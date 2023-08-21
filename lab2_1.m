clear; clc;
syms s;
Gss = 1/((s+2)*(s^2+2*s+3));
Gs=tf(1,conv([1 2],[1 2 3]));


figure(1);clf; hold on; grid on;

syms k real;
[ns,ds] =  numden(Gss);
coef=coeffs(ds,s,'All');
n=length(coef)-1;

opoles = roots(double(coef));
plot(real(opoles),imag(opoles),'kx','LineWidth',2);
kvec=logspace(-1,3,150);
poles=zeros(n,length(kvec));
for i=1:length(kvec)
    kval=kvec(i);
    pcs=kval*ns+ds;
    coef=double(coeffs(pcs,s,'All'));
    poles(:,i)=roots(coef);
end
for i=1:n
    plot(real(poles(i,:)),imag(poles(i,:)),'LineWidth',2);
end

sgrid(0:0.2:1,1:10);
figure(2);clf;
rlocus(Gs);
sgrid(0:0.2:1,1:10);
