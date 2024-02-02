function noise = systemNoise(NF, Rb)
    k = 1.346e-23;
    %T0 = 290;
    T0 = 167.96;
    noise = NF + 10*log10(k*T0*Rb);
end