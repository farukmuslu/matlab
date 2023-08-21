clear;clc;

Gs=tf(1,[1 0.2 25.01]);
syms s;
Gss=1/(s^2+0.2*s+25.01);

os = 10/100;
ts=2;
zeta=-log(os)/sqrt(pi^2+log(os)^2);
wn=4/(ts*zeta);

pds=s^2+2*zeta*wn*s +wn^2;
syms p real; 
pes = s+p;

syms kd kp ki real;
Fss=(kd*s^2+kp*s+ki)/s;
Tss=(Fss*Gss)/(Fss*Gss+1);
[pzs,pcs]=numden(Tss);

coef=coeffs(pcs,s,"All");
coef=coef/coef(1);
prob=coef==coeffs(pds*pes,s,"All");
disp("************************************");
disp("**a");
disp("************************************");
for i=1:length(prob)
    disp(vpa(prob(i),4));
end
sol=solve(prob,[kd,kp,p]);

fun_kd=matlabFunction(sol.kd);
fun_kp=matlabFunction(sol.kp);
fun_p=matlabFunction(sol.p);

kivec=logspace(-1,3,500); 
kivec=linspace(50,150,500); %hassasiyeti arttırdık
tablo=zeros(length(kivec),8);
%ki kp kd ts ose e1 e2 obj
for i=1:length(kivec)
    kival =kivec(i);
    kdval=fun_kd(kival);
    kpval=fun_kp(kival);
    
    Fs=tf([kdval kpval kival],[1 0]);
    Ts=feedback(Fs*Gs,1);
    info=stepinfo(Ts);
    tse=info.SettlingTime;
    ose=info.Overshoot/100;
    e1=abs(tse-ts)/ts;
    e2=abs(ose-os)/os;
    obj=0.5*e1+0.5*e2;
    tablo(i,:)=[kival,kdval,kpval,tse,ose,e1,e2,obj];
end

[val,indx]=min(tablo(:,end));
kival=kivec(indx);
kdval=fun_kd(kival);
kpval=fun_kp(kival);
Fs=tf([kdval kpval kival],[1 0]);
Ts=feedback(Fs*Gs,1);
info=stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot/100;
e1=abs(tse-ts)/ts;
e2=abs(ose-os)/os;
obj=0.5*e1+0.5*e2;

figure(1);clf;hold on;grid on;
plot(kivec,tablo(:,end),'k','LineWidth',2);
plot(kival,val,'rs','LineWidth',2);
set(gca,'XScale','log');

figure(2); clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("t"), ylabel("y(t)");title("Step Response");ax1=gca;legend("show");
subplot(1,2,2);cla;hold on;grid on;xlabel("\sigma"), ylabel("j\omega");title("Pole-zero map");ax2=gca;
[y,t]=step(Ts);
plot(ax1,t,y,'b','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose)+"%");
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'bx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'bo','LineWidth',2);
sgrid(ax2,zeta,wn);

%% kutup-sıfır götürme
disp("************************************");
disp("**b");
disp("************************************");
syms k real;
Fss=k*(s^2+0.2*s+25.01)/s;
Tss=(Fss*Gss)/(Fss*Gss+1);
[pzs,pcs]=numden(Tss);
pcs
k=2;

Fs=2*tf([1 0.2 25.01],[1 0]);
Ts=feedback(Fs*Gs,1);
info=stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot/100;

figure(3); clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("t"), ylabel("y(t)");title("Step Response");ax1=gca;legend("show");
subplot(1,2,2);cla;hold on;grid on;xlabel("\sigma"), ylabel("j\omega");title("Pole-zero map");ax2=gca;
[y,t]=step(Ts);
plot(ax1,t,y,'b','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose)+"%");
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'bx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'bo','LineWidth',2);
sgrid(ax2,zeta,wn); xlim([-3,0.1]);
%% hatalı sistem
Gsh=tf(1,[1 0.19  26]);
%notch filtresi 
Ts=feedback(Fs*Gsh,1);
[y,t]=step(Ts);
plot(ax1,t,y,'b','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose)+"%");
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'mx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'mo','LineWidth',2);
%% 
disp("************************************");
disp("**c");
disp("************************************");
syms k real;
syms p real;
Fss=k*(s^2+0.2*s+25.01)/(s*(s+p));
Tss=(Fss*Gss)/(Fss*Gss+1);
[pzs,pcs]=numden(Tss);
pcs
coef=coeffs(pcs,s,"All");
coef=coef/coef(1);
prob=coef==coeffs(pds,s,"All");
for i=1:length(prob)
    disp(vpa(prob(i),4));
end
sol=solve(prob);

Fs=11.45*tf([1 0.2 25.01],conv([1 0],[1 4]));
Ts=feedback(Fs*Gs,1);
info=stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot;

figure(4); clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("t"), ylabel("y(t)");title("Step Response");ax1=gca;legend("show");
subplot(1,2,2);cla;hold on;grid on;xlabel("\sigma"), ylabel("j\omega");title("Pole-zero map");ax2=gca;
[y,t]=step(Ts);
plot(ax1,t,y,'b','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose)+"%");
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'bx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'bo','LineWidth',2);
sgrid(ax2,zeta,wn); xlim([-3,0.1]);
%% model eşleme kontrol
disp("************************************");
disp("**d");
disp("************************************");

%pds
Tds=tf(wn^2,[1 2*zeta*wn wn^2]);
Lds=(Tds)/(1-Tds);
Lds=minreal(Lds);
Fs=Lds/Gs;

figure(5);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("t"), ylabel("y(t)");title("Step Response");ax1=gca;legend("show");
subplot(1,2,2);cla;hold on;grid on;xlabel("\sigma"), ylabel("j\omega");title("Pole-zero map");ax2=gca;
Ts=feedback(Fs*Gsh,1);
[y,t]=step(Ts);
plot(ax1,t,y,'m','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose)+"%");

[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'bx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'bo','LineWidth',2);