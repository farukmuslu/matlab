clear;

Gs=tf(1,[1 2]);
%impuls, step, ramp 


[yi,ti]=step(Gs*tf([1 0],1));
[ys,ts]=step(Gs);
[yr,tr]=step(Gs*tf(1,[1 0]));

figure(1);clf;
subplot(3,1,1);cla;hold on;grid on;
plot(ti,yi,'b','LineWidth',2);
subplot(3,1,2);cla;hold on;grid on;
plot(ts,ones(size(ts)),'k','LineWidth',2);
plot(ts,ys,'b','LineWidth',2);
subplot(3,1,3);cla;hold on;grid on;
plot(tr,tr,'k','LineWidth',2);
plot(tr,yr,'b','LineWidth',2);