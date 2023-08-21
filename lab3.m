clear; clc;
Gs=tf(1,conv([1 0],conv([1 5],[1 8])));
syms s;
Gss=1/(s*(s+5)*(s+8));

syms k real;
Tss = (k*Gss)/(1+k*Gss);
%pc(s) -> karakteristik polinom %pe(s) -> reside polinom %pd(s) -> desired polinom %pz(s) -> sıfır polinomu
[pzs, pcs]=numden(Tss);

ts=4;% ts=4,ts=2.5,ts=1.5 değerlerini dene ve sonuçları karşılaştır, kritik sönümlü P tipi kontrolör nedir?   
syms wn real;
%Gss=wn^2/(s^2+2*zeta*wn*s+wn^2);
%yt=ilaplace(Gss/s);pretty(simplify(yt))
%ts=4/(zeta*wn)==4/sigma; ------>settling time
zeta = 4/(ts*wn);
pds=s^2+2*zeta*wn*s+wn^2;

syms p real;
pes=s+p;
prob=coeffs(pcs,s,'all')==coeffs(pds*pes,s,'all');
for i=length(prob)
    disp(vpa(prob(i),4))
end
sol = solve(prob);
kval=double(sol.k);
pval=double(sol.p);
wnval=double(sol.wn);
indx=wnval>=0;
wnval=wnval(indx);
kval=kval(indx);
pval=pval(indx);
zetaval=4/(ts*wnval);

Fs = kval;
Ts = feedback(Fs*Gs,1);

figure(1);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("time");ylabel("y(t)");title("Step Response");legend('show');ax1=gca;
subplot(1,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("Root-Locus Plot");ax2=gca;
[y,t]=step(Ts,1.5*ts);
info = stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot;
plot(ax1,t,y,'k','LineWidth',2,'DisplayName',['tse:',num2str(tse),'ose:',num2str(ose)]);

rlocus(ax2,Gs);
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'kx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'ko','LineWidth',2);
sgrid(ax2,zetaval,[wnval,pval]);
plot(ax2,-ones(1,2)*(4/ts),ylim(ax2),'k--','LineWidth',2);
