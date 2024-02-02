function h_ln = linkHeight(h1, h2 ,d1, d2)
    h_ln = h1 * d2/(d1+d2) + h2 * d1/(d1+d2);
end