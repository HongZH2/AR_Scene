%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Function to run the whole process
% Witten by: Hong Zhang and Shimian Zhang
% Email: hmz5180@psu.edu svz5303@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;
clc;

% add file path
addpath(genpath('./OBJRead'));
addpath(genpath('./3Dmodel'));


% read the point cloud 
ptCloud = pcread('./Data/fused.ply');

% load the 3d model
obj_path = './3Dmodel/chicken_01.obj';
obj_colormap = './3Dmodel/chicken_01.jpg';
obj_3d = readObj(obj_path);

%% Part 1: entries
% Given Point Clould, find the dominant plane by using Ransac, read/display
% 3D object, create the local object coordinate and designed object
% coordinate on the dominant plane,then make them overlapped by computing
% transformation matrix
% Coder: Hong Zhang 
obj_3d = dominant_plane_finding(ptCloud, obj_3d, obj_colormap);


%% Part 2: entries
% Read camera pose, inner parameter and compute transformation matrix
% bewteen designed object coordinate and cameras. Finally re-project the 3d
% object back to the image.
% Coder: Shimian Zhang 
camera_projecting(ptCloud, obj_3d, obj_colormap);
