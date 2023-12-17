% r - radius of the antenna in meters
% lambda - wave length in meters
% beamW - antenna's bead width in degrees
function beamW = beamWidth(lambda, r)
    beamW = 70 * lambda/(2*r);
end