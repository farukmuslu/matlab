%ikinci dereceden sistem
%wn etkisi
clear;clc;
figure(3);clf;  
subplot(2,2,1);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Step");ax1=gca;
subplot(2,2,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("s-domain");ax2=gca;
subplot(2,2,3);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Step");ax3=gca;
subplot(2,2,4);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("s-domain");ax4=gca;

t=0:0.01:10;
zeta=1;
wnvec = 0.5:0.5:4;
for i=1:length(wnvec)
    wn=wnvec(i);
    color=[0,0,i/length(wnvec)];

    Gs=tf(wn^2,[1 2*zeta*wn wn^2]);
    sigma = -zeta*wn;
    wd=wn*sqrt(1-zeta^2);
    
    [y,~]=step(Gs,t);
    plot(ax1,t,y,'Color',color,'LineWidth',2);
    plot(ax2,sigma,wd,'x','Color',color,'LineWidth',2);
    plot(ax2,sigma,-wd,'x','Color',color,'LineWidth',2);
   
end
sgrid(ax2,zeta,wnvec); 
% xlim(ax2,[-1.5,0.5]);
% ylim(ax2,[-1.5,1.5]);
% plot(ax3,zetavec,3.91./(zetavec*wn),'k','LineWidth',2);
% plot(ax3,wn*zetavec,tsvec,'Color','r','LineWidth',2);
zeta=0.5;
for i=1:length(wnvec)
    wn=wnvec(i);
    color=[0,0,i/length(wnvec)];

    Gs=tf(wn^2,[1 2*zeta*wn wn^2]);
    sigma = -zeta*wn;
    wd=wn*sqrt(1-zeta^2);
    
    [y,~]=step(Gs,t);
    plot(ax3,t,y,'Color',color,'LineWidth',2);
    plot(ax4,sigma,wd,'x','Color',color,'LineWidth',2);
    plot(ax4,sigma,-wd,'x','Color',color,'LineWidth',2);
end
%sgrid(ax2,zetavec,wn); 