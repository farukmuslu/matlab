%% Bode-Stability
clear;clc;
s = tf('s');
Gs = exp(-3*s)/(s^4 + 16*s^3 + 92*s^2 + 224*s + 192); % for positive k
Gsn = -Gs; % for negative k

%% Gs
figure(1);clf;
margin(Gs);grid on;
figure(2);clf;
margin(Gsn);grid on;

[Gm,Pm,~,~] = margin(Gs);
% Calculate Kmax
if Pm > 0
    Kmax = Gm;
else
    Kmax = inf;
end

[Gmn,Pmn,~,~] = margin(Gsn);
% Calculate Kmin 
if Pmn > 0
    Kmin = -Gmn;
else
    Kmin = -inf;
end

fprintf(' Gs stability range is   %g  <  k  <  %g\n  ', Kmin,Kmax);