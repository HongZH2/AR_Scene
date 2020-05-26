function Pi = WorldToImage(Pw, f, cx, cy, k, R, T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJECTION To transform the points in world system to an image by camera
% parameters. Use simple radial camera model.
%
% Input: 
%       Pw  3x1 3D point in world coordinate
%       f   scalar of camera focal, internal parameter of camera
%       cx  internal parameter of camera
%       cy  internal parameter of camera
%       k   internal parameter of camera
%       R   3x3 rotation matrix, external parameter of camera
%       T   3x1 translation matrix, external parameter of camera
%
% Output: 
%       Pi  2x1 2D point in image coordinate
%
% Witten by: Shimian Zhang
% Email: svz5303@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Projection
    P = [R,T]*[Pw;1];
    u = P(1)./P(3);
    v = P(2)./P(3);

    % Distortion
    radial = k*(u*u + v*v);
    x = u*(1+radial);
    y = v*(1+radial);

    % Transform to image coordinates
    x = f*x + cx;
    y = f*y + cy;
    Pi = [x;y];
return

