function [magd,phased]=DelayedMagPhase(mag,phase,w,tau)
magd=mag;
phased= phase -w*tau*180/pi;
end