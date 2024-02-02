% Antenna Gain to Noise temperature ratio (G/T) or "Figura de mérito"
% G - Gain at reception in dB
% l - Losses at reception in dB
% T0 - Temperature of the system
% NF - Noise Figure in dB
% Ts - System noise in kelvin
function fM =  receptionGain(G, l, NF, Ts)
    fM = (G + l) - (10*log10(Ts) + NF);
end