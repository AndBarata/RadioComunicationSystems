% Free Space Losses in dB
% lambda - wave lenght in meters
% d - distance between to points in meters
function fsl = FSL(lambda, d)
    fsl = 20*log10(lambda/(4*pi*d));
end