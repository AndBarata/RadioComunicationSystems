% Power density - total power times the effective area
% Pr - Total power recived in dB
% e - Antenna efficiency
% A - Area of the antenna

function W = powerDensity(Pr, e, A)
    W = Pr + 10*log10(e*A);
end