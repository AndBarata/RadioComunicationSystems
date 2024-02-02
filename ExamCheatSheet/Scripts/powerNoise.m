function N = powerNoise(B, Ts)
    k = 1.346e-23;
    T0 = 290;
    N = 10*log(k*Ts*B);
end