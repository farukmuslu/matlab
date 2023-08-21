clear;clc;

Gs=tf(100,conv([1 0],conv([1 2],[1 5])));
syms s;
Gss=100/(s*(s+2)*(s+5));

os=10/100;
ts=4;
zeta=-log(os)/sqrt(pi^2+log(os)^2);
wn=4/(zeta*ts);

pds = s^2 + 2*zeta*wn*s+wn^2;

%kutup sıfır götürmesi s=-2
syms k z real;
Fss=k*(s+z)*(s+2)/s;
Tss = (Fss*Gss)/(1+Fss*Gss);
[pzs,pcs]=numden(Tss);
 
syms p real;
pes=s+p;

prob=coeffs(pcs,s,'All')==coeffs(pds*pes,s,'All');
for i=1:length(prob)
    disp(vpa(prob(i),4));
end
sol = solve(prob);
kval=double(sol.k);
pval=double(sol.p);
zval=double(sol.z);

Fs=kval*tf(conv([1 zval],[1 2]),[1 0]);
Ts=feedback(Gs*Fs,1);
zpk(Ts)
Ts

info = stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot;

figure(1);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("time");ylabel("y(t)");title("Step Response");legend("show");ax1=gca;
subplot(1,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("Root Locus");ax2=gca;

[y,t]=step(Ts);
plot(ax1,t,y,'k','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose));

rlocus(ax2,tf(conv([1 zval],[1 2]),[1 0])*Gs);
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'kx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'ko','LineWidth',2);
sgrid(ax2,zeta,wn);
ylim(ax2,[-3 3]);

%kutup sıfır götürmesi s=-5
syms k z real;
Fss=k*(s+z)*(s+5)/s;
Tss = (Fss*Gss)/(1+Fss*Gss);
[pzs,pcs]=numden(Tss);
 
syms p real;
pes=s+p;

prob=coeffs(pcs,s,'All')==coeffs(pds*pes,s,'All');
for i=1:length(prob)
    disp(vpa(prob(i),4));
end
sol = solve(prob);
kval=double(sol.k);
pval=double(sol.p);
zval=double(sol.z);

Fs=kval*tf(conv([1 zval],[1 5]),[1 0]);
Ts=feedback(Gs*Fs,1);
zpk(Ts)
Ts

info = stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot;

figure(2);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("time");ylabel("y(t)");title("Step Response");legend("show");ax1=gca;
subplot(1,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("Root Locus");ax2=gca;

[y,t]=step(Ts);
plot(ax1,t,y,'k','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose));

rlocus(ax2,tf(conv([1 zval],[1 5]),[1 0])*Gs);
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'kx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'ko','LineWidth',2);
sgrid(ax2,zeta,wn);
ylim(ax2,[-3 3]);

%kutup sıfır götürmesi s=-5,s=-2

Fss=k*(s+2)*(s+5)/s;
simplify(Fss*Gss)
figure(3);clf;hold on;
rlocus(tf(100,[1 0 0]));

