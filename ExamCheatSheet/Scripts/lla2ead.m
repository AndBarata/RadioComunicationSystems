% return a vector with elevation, azimuth and distance (+N, +E, -S, -W)
% lat - latitude in degree
% long - Variation of longitude (long_estation - longitude_sat) in degree
% rs - sat orbit radius in meters
function [elevation, azimuth, distance] = lla2ead(lat, long_e, long_s)
    rt = 6378e3;
    rs = 42164e3;
    lat = deg2rad(lat);
    long = deg2rad(long_e) - deg2rad(long_s);

    epsi = acos(cos(lat)*cos(long));
    disp(epsi)
    elevation = atan( ( cos(epsi) - rt/rs) / sin(epsi) );
    azimuth = acos(-tan(lat) / tan(epsi));
    distance = rs * sqrt( 1 + (rt/rs)^2 - 2 * rt/rs * cos(epsi) );

    elevation = rad2deg(elevation);
    azimuth = rad2deg(azimuth);
end