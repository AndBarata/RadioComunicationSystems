% e - efficiency
% r - radius of the antenna in meters
% lambda - wave length in meters
% Again - gain of the antenna in dB
function Again = antennaGain(e, r, lambda)
    Again = 10*log10((e*pi*r^2)/(lambda^2/(4*pi)));
end