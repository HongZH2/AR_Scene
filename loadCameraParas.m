function [int_paras, ext_paras] = loadCameraParas(camera_path, image_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJECTION Read camera.txt and image.txt to get internal and external
% parameters of cameras
%
% Input: 
%       camera_path     path of camera.txt  
%       image_path      path of image.txt
%
% Output: 
%       int_paras   1xN struct of internal parameters of each camera
%       ext_paras   1xN struct of external parameters of each camera
%
% Witten by: Shimian Zhang
% Email: svz5303@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% read camera.txt
    camera_file = fopen(camera_path,'r');
    % internals = [CAMERA_ID, MODEL, WIDTH, HEIGHT, f, cx, cy, k] 
    internals = textscan(camera_file,'%d %s %f %f %f %f %f %f', 'headerlines',3);
    cam_num = size(internals{1},1);
    for i=1:cam_num
        int_paras(i) = struct('W', internals{3}(i), 'H', internals{4}(i), ...
        'paras', [internals{5}(i), internals{6}(i), internals{7}(i), internals{8}(i)]);
    end
    
    %% read image.txt
    image_file = fopen(image_path,'r');
   
    %externals = textscan(image_file,'%d %f %f %f %f %f %f %f %d %s', 'headerlines',4);
    
    for i=1:4
        fgetl(image_file);
    end
    count = 1;
    while feof(image_file)~=1
        line = fgetl(image_file);
        % external = [IMAGE_ID, QW, QX, QY, QZ, TX, TY, TZ, CAMERA_ID, NAME] 
        external= textscan(line, '%d %f %f %f %f %f %f %f %d %s');
        Q = [external{2}, external{3}, external{4}, external{5}];
        T = [external{6}, external{7}, external{8}];
        id = external{9};

        R = quat2rotm(Q);
        ext_paras(count) = struct('R', R, 'T', T, 'id', id, 'Name', external{10});
        % skip points
        fgetl(image_file);
        count = count+1;
    end
return

