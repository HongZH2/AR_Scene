function [object, transform_mat] = transform_3Dobject(object, origin, up, forw, left)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRANSFORM_3DOBJECT To transform the 3D object to the default object
% coordinate
% Input: origin and vectors of object coordinate
%        3d object
% Output: transformation matrix
% Witten by: Hong Zhang
% Email: hmz5180@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find the bounding box for the object
% set the default direction that object face to , if you change a model you
% need to change it.
forw_o = [0, 0, 1]; % corresponding to x axis
up_o = [0, 1, 0]; % corresponding to z axis
left_o = [1, 0, 0]; % corresponding to y axis

%  scaling the object
scaling = 0.04;
object.v = object.v * scaling;


% get the foot_center
min_y = min(object.v(:,2));
foot_center = [0, min_y, 0];
% transform the object to the foot-centered position
object.v = object.v - foot_center;

% we will make the up_o to x to up, forw_o to y to forw and left_o to z to left
% Firstly transform the default object into the point cloud world
% coordinate, Then transformation to designed Object coordinate

% Firstly transform the default object into the point cloud world
% coordinate: Identity = R_default_w*[forw_o', left_o', up_o']

R_default_w = [forw_o', left_o', up_o']';

% Then transformation to designed Object coordinate: [forw', left', up'] =
% R_w_obj*Identity
R_w_obj = [forw', left', up'];

object.v = (R_w_obj * R_default_w * object.v')';

% transform the object to designed position
object.v = object.v + origin;

% get the final transfomation matrix
transform_mat =  [eye(3) origin';[0 0 0 1]] * scaling * [R_w_obj [0,0,0]';[0 0 0 1]]*[R_default_w [0,0,0]';[0 0 0 1]] ...
                 * [eye(3) -foot_center';[0 0 0 1]];
transform_mat = transform_mat / transform_mat(4,4);

end

