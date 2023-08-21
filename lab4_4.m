%ikinci dereceden sistem
%p- kutup etkisi
clear;clc;
figure(4);clf;  
subplot(2,2,1);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Step");ax1=gca;
subplot(2,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("s-domain");ax2=gca;
subplot(2,2,3);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Step");ax3=gca;
subplot(2,2,4);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("s-domain");ax4=gca;

t=0:0.01:20;
pvec = 2:1:10;
zeta=0.5; wn=0.5;
for i=1:length(pvec)
    p=pvec(i);
    color=[0,0,i/length(pvec)];

    Gs=tf(wn^2,[1 2*zeta*wn wn^2])*tf(p,[1 p]);
    sigma = -zeta*wn;
    wd=wn*sqrt(1-zeta^2);
    
    [y,~]=step(Gs,t);
    plot(ax1,t,y,'Color',color,'LineWidth',2);
    plot(ax2,sigma,wd,'x','Color',color,'LineWidth',2);
    plot(ax2,sigma,-wd,'x','Color',color,'LineWidth',2);
    plot(ax2,-p,0,'x','Color',color,'LineWidth',2);   
end
sgrid(ax2,zeta,[wn pvec]); 

pvec = 0.1:0.1:0.5;
for i=1:length(pvec)
    p=pvec(i);
    color=[0,0,i/length(pvec)];

    Gs=tf(wn^2,[1 2*zeta*wn wn^2])*tf(p,[1 p]);
    sigma = -zeta*wn;
    wd=wn*sqrt(1-zeta^2);
    
    [y,~]=step(Gs,t);
    plot(ax3,t,y,'Color',color,'LineWidth',2);
    plot(ax4,sigma,wd,'x','Color',color,'LineWidth',2);
    plot(ax4,sigma,-wd,'x','Color',color,'LineWidth',2);
    plot(ax4,-p,0,'x','Color',color,'LineWidth',2);   
end
sgrid(ax4,zeta,[wn pvec]); 

