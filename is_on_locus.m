function [result,theta,k]=is_on_rlocus(num,den,pole)
n=roots(num);
d =roots(den);
theta_p = atan2d((imag(pole)-imag(d)),(real(pole)-real(d))); 
theta_z = atan2d((imag(pole)-imag(n)),(real(pole)-real(n))); 
theta_calc =round(sum(theta_z)-sum(theta_p));
k_calc = prod(sqrt(real(pole-d).^2+imag(pole-d).^2))/prod(sqrt(real(pole-n).^2+imag(pole-n).^2));
if mod(theta_calc,360)==0
     theta=theta_calc;
     result = true;
     k=-k_calc;
elseif mod(theta_calc,180)==0
     theta=theta_calc;
     result = true;
     k=k_calc;
else
     result = false;  
     theta = theta_calc;
     k = [];
end
end


