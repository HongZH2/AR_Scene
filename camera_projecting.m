function [] = camera_projecting(ptCloud, obj_3d, obj_colormap)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Camera Projection Script: To fit a dominant plane in the point cloud 
% Witten by: Shimian Zhang
% Email: svz5303@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read the camera information
camera_path = './Data/cameras.txt';
image_path = './Data/images.txt';

% set the dataset path
dataset_path = './Data/dataset';

% set the result path
result_path = './results';

%% Load Camera Parameters
[int_paras, ext_paras] = loadCameraParas(camera_path, image_path);

%% Show the camera pose on previous figure
plotCameraPose(ext_paras);

%% Project 3D World into 2D Images
cam_num = size(ext_paras,2);
for i=1:cam_num
    fprintf('Start Projection for Camera %d\n', i);
    
    Projection(obj_3d, obj_colormap, dataset_path, result_path, ...
        int_paras(1), ext_paras(i));
end

