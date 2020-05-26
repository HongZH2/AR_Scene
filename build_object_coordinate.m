function [Origin, Up, Forward, Left] = build_object_coordinate(parameters_plane)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BUILD_OBJECT_COORDINATE Summary of this function goes here
% Input: parameters of plane: [a ,b, c, d]
% Output: the Origin of object, the three vector
% Witten by: Hong Zhang
% Email: hmz5180@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Build a local object coordinate
% get the normal vector of plane
Up = -parameters_plane(1:3)/norm(parameters_plane(1:3));

% set a default position of Origin 
x_0 = 2;
y_0 = 1;
z_0 = - (parameters_plane(1)*x_0 + parameters_plane(2)*y_0 + parameters_plane(4));
Origin = [x_0, y_0, z_0];

% set a forward vector
x_1 = -1;
y_1 = 2;
z_1 = - (parameters_plane(1)*x_1 + parameters_plane(2)*y_1 + parameters_plane(4));

Forward = [x_1 - x_0, y_1 - y_0, z_1 - z_0];
Forward = Forward/norm(Forward);

% compute the left vector
Left = cross(Up, Forward);
Left = Left/norm(Left);
end

