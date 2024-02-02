function r1 = fresnel(d1, d2, lambda, n)
    r1 = sqrt( n * lambda*d1*d2 / (d1 + d2) );
end