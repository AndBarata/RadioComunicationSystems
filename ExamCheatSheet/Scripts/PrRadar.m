% Power received for the reflection
% Ga - Gain of the antenna in dB
% Pe - Power emitted in dB
% lambda - Wavelength in meters
% tau - Reflectivity of the material 
% r - distance to the object in meters
% Gproc - Processing gain in dB
% Aiso - Isotropic area of the antenna
function Pr = PrRadar(Ga, Pe, lambda, tau, r, Gproc, Aiso)
    Pr = Pe + 2*Ga + Gproc + 10*log10( (lambda^2 * tau/Aiso) / ( (4*pi)^3 * (r^4) ) );
end