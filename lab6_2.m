clear;clc;

Gs=tf(100,conv([1 0],conv([1 2],[1 5])));
syms s;
Gss=100/(s*(s+2)*(s+5));

os=10/100;
ts=4;
zeta=-log(os)/sqrt(pi^2+log(os)^2);
wn=4/(zeta*ts);

pds = s^2 + 2*zeta*wn*s+wn^2;


syms kp ki kd real;
Fss=(kd*s^2+kp*s+ki)/s;
Tss = (Fss*Gss)/(1+Fss*Gss);
[pzs,pcs]=numden(Tss);
 
syms a b real;
pes=s^2+a*s+b; 

prob=coeffs(pcs,s,'All')==coeffs(pds*pes,s,'All');
for i=1:length(prob)
    disp(vpa(prob(i),4));
end
sol = solve(prob,[a,b,kd,kp]);

kivec=0:0.00001:0.01;
tablo=zeros(length(kivec),6);
fun_kd=matlabFunction(sol.kd);
fun_kp=matlabFunction(sol.kp);
tic;
for i=1:length(kivec)
    kival=kivec(i);
%     kdval =double(subs(sol.kd,ki,kival)); subs yavaş bir fonksiyon
%     kpval =double(subs(sol.kd,ki,kival));
    kpval=fun_kp(kival); %subs yerine bunu kullandık    
    kdval=fun_kd(kival);
    Fs=tf([kdval kpval kival],[1 0]); %kontrolör hazır
    Ts=feedback(Fs*Gs,1);  
    info = stepinfo(Ts);
    tse=info.SettlingTime;
    ose=info.Overshoot/100;
    
    e1=abs(tse-ts)/ts;  %bağıl hataya bakıyoruz
    e2=abs(ose-os)/ose; %hataların birimi farklı old. için
    obj=0.5*e1+0.5*e2;  %hataları aynı oranda önemsedik
    tablo(i,:)=[kival,kdval,kpval,tse,ose,obj];
end
toc;
figure(4);clf; grid on; hold on;
xlabel("ki");ylabel("obj");title("Objective");set(gca,'XScale','log')
plot(kivec,tablo(:,end),'k','LineWidth',2);

[val,indx]=min(tablo(:,end));
plot(kivec(indx),val,'ks','LineWidth',2);

kival=tablo(indx,1);
kdval=tablo(indx,2);
kpval=tablo(indx,3);
Fs=tf([kdval kpval kival],[1 0]);
Ts=feedback(Fs*Gs,1);  
info = stepinfo(Ts);
tse=info.SettlingTime;
ose=info.Overshoot; 
figure(5);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("time");ylabel("y(t)");title("Step Response");legend("show");ax1=gca;
subplot(1,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("Root Locus");ax2=gca;

[y,t]=step(Ts);
plot(ax1,t,y,'k','LineWidth',2,'DisplayName',"ts:"+string(tse)+" os:"+string(ose));
rlocus(ax2,tf([kdval kpval kival]/kdval,[1 0])*Gs);
[cpoles,czeros]=pzmap(Ts);
plot(ax2,real(cpoles),imag(cpoles),'kx','LineWidth',2);
plot(ax2,real(czeros),imag(czeros),'ko','LineWidth',2);
sgrid(ax2,zeta,wn);
% ylim(ax2,[-3 3]);