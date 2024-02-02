% Minimum received power for a given SNR
% SNR . SNR in bD
% B - Bandwidth in Hz
% NF - Noise Figure
function Pr = PrRadarMin(SNR, B, NF)
    k = 1.3460e-23;
    T0 = 290;
    Pr = 10*log10(k*T0*B) + NF + SNR;
end