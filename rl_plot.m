clc;clear ;close all;
for k=0:0.1:10  % roots = kökler
    %p=roots([1 1 k]); % Open loop TF=> G(s)H(s)=K/(s*(s+1)) 
    p=roots([1 1+k 2*k]); % Open loop TF=> G(s)H(s)=K(s+2)/(s*(s+1))
    real_p1=real(p(1));
    imag_p1=imag(p(1));
    real_p2=real(p(2));
    imag_p2=imag(p(2));
    plot(real_p1,imag_p1,'g*', real_p2,imag_p2,'bo');
    hold on
end
