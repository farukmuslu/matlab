%birinci dereceden sistem
clear;clc;
figure(1);clf;  
subplot(1,4,1);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Impulse");legend("show","Location","best");ax1=gca;
subplot(1,4,2);cla;hold on;grid on;xlabel("t");ylabel("y(t)");title("Step");ax2=gca;
subplot(1,4,3);cla;hold on;xlabel("\sigma");ylabel("j\omega");title("s-domain");ax3=gca;
subplot(1,4,4);cla;hold on;grid on;xlabel("wn");ylabel("t_s");title("Settling Time");ax4=gca;
t=0:0.01:10;
wnvec = 0.5:0.1:2;
tsvec=zeros(size(wnvec));
for i=1:length(wnvec)
    wn=wnvec(i);
    color=[0,0,i/length(wnvec)];

    Gs=tf(wn,[1 wn]);
    tsvec(i)=stepinfo(Gs).SettlingTime;

    [y,~]=step(Gs,t);
    [yi,~]=step(Gs*tf([1 0],1),t);
    
    plot(ax1,t,yi,'Color',color,'LineWidth',2,'DisplayName',['wn:',num2str(wn)]);
    plot(ax2,t,y,'Color',color,'LineWidth',2);
    plot(ax3,-wn,0,'x','Color',color,'LineWidth',2);
    if i>1
    plot(ax4,wnvec(i-1:i),tsvec(i-1:i),'Color',color,'LineWidth',2);
    end
end

sgrid(ax3,1,wnvec(1):0.5:wnvec(end)); 
xlim(ax3,[-2.5,0.5]);
plot(ax4,wnvec,3.91./wnvec,'k','LineWidth',2);