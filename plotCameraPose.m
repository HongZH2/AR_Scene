function plotCameraPose(ext_paras)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJECTION Show the camera poses on previous figure
%
% Input: 
%       ext_paras           external parameters of the camera
%
% Witten by: Shimian Zhang
% Email: svz5303@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cam_num = size(ext_paras,2);
    hold on
    for i=1:cam_num
        % draw each camera position
        orientation = ext_paras(i).R';
        location = -orientation*ext_paras(i).T';
        plotCamera('Location', location, 'Orientation', orientation', 'Size', 0.2);
    end
return