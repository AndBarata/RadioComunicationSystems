% Noise figure but not in dB
% NF - Noise figure in dB
function f = noiseFactor(NF)
    f = 10^(NF/10);
end