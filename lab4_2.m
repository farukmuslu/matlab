%ikinci dereceden sistem 
%zeta etkisi
clear;clc;
figure(2);clf;  
subplot(1,3,1);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Step");ax1=gca;
subplot(1,3,2);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("s-domain");ax2=gca;
subplot(1,3,3);cla;hold on;grid on;xlabel("\sigma");ylabel("t_s");title("Settling Time");ax3=gca;

t=0:0.01:10;
wn=1;
zetavec = 0:0.1:1;
tsvec=zeros(size(zetavec));
for i=1:length(zetavec)
    zeta=zetavec(i);
    color=[0,0,i/length(zetavec)];

    Gs=tf(wn^2,[1 2*zeta*wn wn^2]);
    sigma = -zeta*wn;
    wd=wn*sqrt(1-zeta^2);
    tsvec(i)=stepinfo(Gs).SettlingTime;
    
    [y,~]=step(Gs,t);
    plot(ax1,t,y,'Color',color,'LineWidth',2);
    plot(ax2,sigma,wd,'x','Color',color,'LineWidth',2);
    plot(ax2,sigma,-wd,'x','Color',color,'LineWidth',2);
   
end
sgrid(ax2,zetavec,wn); 
xlim(ax2,[-1.5,0.5]);
ylim(ax2,[-1.5,1.5]);
plot(ax3,zetavec,3.91./(zetavec*wn),'k','LineWidth',2);
plot(ax3,wn*zetavec,tsvec,'Color','r','LineWidth',2);
