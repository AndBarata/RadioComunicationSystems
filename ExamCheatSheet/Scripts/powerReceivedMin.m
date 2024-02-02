% Power at the receiver P_r 
% EbN0 - Power at the antenna in dB
% NF - Noise Figure in dB
% Rb - Binary Rate in Hz
function Pr = powerReceivedMin(EbN0, NF, Rb)
    k = 1.346e-20;
    T0 = 290;
    Pr = EbN0 + NF + 10*log10(T0 * Rb * k);
end