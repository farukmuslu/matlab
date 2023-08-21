clear;clc;%ziegler nichols-nihai çözüm için değil başlangıç noktası için daha mantıklı-

Gs=tf(100,conv([1 0],conv([1 2],[1 5])));
syms s;
Gss=100/(s*(s+2)*(s+5));
os=10/100;
ts=4;
zeta=-log(os)/sqrt(pi^2+log(os)^2);
wn=4/(zeta*ts);

pds = s^2 + 2*zeta*wn*s+wn^2;

syms k real;
Tss=(k*Gss)/(1+k*Gss);
[pzs,pcs]=numden(Tss);

syms w real;
pw=subs(pcs,s,1i*w);
prob=[real(pw)==0,imag(pw)==0];
sol=solve(prob);

figure(6);
rlocus(Gs);

wval=double(sol.w);
kval=double(sol.k);
wc=wval(2);
Tc=2*pi/wc;
kc=kval(2);

kp=0.6*kc;
ki=kp/(0.5*Tc);
kd=kp/(0.125*Tc);

Fs=tf([kd kp ki],[1 0]);
Ts=feedback(Fs*Gs,1);  
info = stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot; 
figure(7);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("time");ylabel("y(t)");title("Step Response");legend("show");ax1=gca;
subplot(1,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("Root Locus");ax2=gca;

[y,t]=step(Ts);
plot(ax1,t,y,'k','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose));
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'kx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'ko','LineWidth',2);
sgrid(ax2,zeta,wn);
