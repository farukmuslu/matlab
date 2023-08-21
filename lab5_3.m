clear; clc;
%%PI kontrolör

zeta=1;
wn=2;
Gs=tf(wn^2,[1 2*zeta*wn wn^2]);
syms s;
Gss=wn^2/(s^2+2*zeta*wn*s+wn^2);

os=10/100;
zeta=-log(os)/sqrt(pi^2+log(os)^2);

syms wn real;
pds=s^2+2*zeta*wn*s+wn^2;
syms p real;
pes = s+p;

z=4;
syms k  real;
Fss=k*(s+z)/s;
Tss=(Fss*Gss)/(1+Fss*Gss);
Tss=simplifyFraction(Tss);
pretty(Tss)

[pzs,pcs] = numden(Tss);
prob=coeffs(pcs,s,"All")==coeffs(pes*pds,s,"All");
for i=1:length(prob)
    disp(vpa(prob(i),4))
end
sol=solve(prob);
kval=double(sol.k);
wnval=double(sol.wn);
pval=double(sol.p);

figure(3);clf;
subplot(1,2,1);cla;hold on;grid on;xlabel("t");title("Step Response");ax1=gca;legend("Show");
subplot(1,2,2);cla;hold on;grid on;xlabel("\sigma");ylabel("j\omega");title("Root-Locus plot"),ax2=gca;

colors = {'r','b','m'};


    Fs=kval*tf([1 z],[1 0]);
    Ts=feedback(Fs*Gs,1);
    [y,t]=step(Ts,15);
    info=stepinfo(Ts);
    ose=info.Overshoot;
    tse=info.SettlingTime;
    
    %plot(ax1,t,ones(size(t)),'k','LineWidth',2,'DisplayName','reference');
    plot(ax1,t,y,'r','LineWidth',2,'DisplayName',"ts:"+string(tse)+"os:"+string(ose)+"%");
    
    if kval>0
        rlocus(ax2,Gs*tf([1 z],[1 0]));
    else
        rlocus(ax2,-Gs*tf([1 zval(i)],[1 0]));
    end
    [cpoles,czeros]=pzmap(Ts);
    plot(ax2,real(cpoles),imag(cpoles),'x','Color','r','LineWidth',2);
    plot(ax2,real(czeros),imag(czeros),'o','Color','r','LineWidth',2);
    sgrid(ax2,zeta,wnval)

%xlim(ax2,[-4,0.5])

