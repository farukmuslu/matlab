clear;clc;

syms s;
Gss= 1/(s+1);
Gs=tf(1,[1,1]);

syms w real;
Gjw=subs(Gss,s,1i*w);

wvec=logspace(-2,2,100);
mag=zeros(size(wvec));
phase=zeros(size(wvec));
for i=1:length(wvec)
    wval = wvec(i);
    Gw=subs(Gjw,w,wval);
    mag(i)=abs(Gw);
    phase(i)=angle(Gw)*180/pi;
end

figure(1);clf;
subplot(2,2,1);cla;hold on;grid on;xlabel('w');ylabel('Magnitude');set(gca,'XScale','log');ax1=gca;
subplot(2,2,3);cla;hold on;grid on;xlabel('w');ylabel('Phase');set(gca,'XScale','log');ax2=gca;
plot(ax1,wvec,20*log10(mag),'b','LineWidth',2);
plot(ax2,wvec,phase,'b','LineWidth',2);

wval=1;
[val,indx]=min(abs(wvec-wval));
plot(ax1,wvec(indx),mag(indx),'rx','LineWidth',2);
plot(ax2,wvec(indx),phase(indx),'rx','LineWidth',2);

t=0:0.01:30;
w=randn(size(t));
w=w-mean(w);
u=sin(wval*t)+sin(20*t);
[y,t]=lsim(Gs,u,t);
subplot(2,2,[2,4]);cla;hold on;grid on;xlabel('t');ylabel('y(y)');
%%plot(t,w,'b','LineWidth',2);
plot(t,u,'b','LineWidth',2);
plot(t,y,'r','LineWidth',2);

%[mag,phase,w]=bode(Gs);
% mag=mag(:);
% phase=squeeze(phase);

%%[poles,kvec] = rlocus(Gs);
