function [inlier_indices,outlier_indices] = RANSAC_PlaneFitting(ptCloud, dist_threshold, iteration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANSAC_PLANEFITTING: To fit a 3D plane by using RANSAC algorithm
% Input: ptCloud: Point Cloud
%        dist: distance threshold
%        angle: angle threshold
%        iteration: maximum numbers of iteration
% Output: the indice of inliers in the ptCloud
% Witten by: Hong Zhang
% Email: hmz5180@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Global Variables
max_count = 0; % record the maximum
inlier_indices = [];
nums = size(ptCloud.Location,1); 

disp ('Start RANSAC');
i = 1;
while i < iteration
    %% Select three 3D points from ptCloud to set the model
    % I select three points randomly from the ptCloud. They shouldn't lie on
    % the same line, but it rarely happens so don't worry about it  
    id_A = ceil(rand*nums);
    id_B = ceil(rand*nums);
    id_C = ceil(rand*nums);
    A = ptCloud.Location(id_A,:);
    B = ptCloud.Location(id_B,:);
    C = ptCloud.Location(id_C,:);
    % compute the parameters of 3D plane: ax + by + cz + d = 0
    AB = B - A;
    BC = C - B;
    % get the normal vector of the model
    n_vec = cross(AB, BC);
    n_vec = n_vec/norm(n_vec);
    d = - dot(n_vec, A);

    %% counter for inliers that meets the current model
    point_data = ptCloud.Location;
    % compute all the distance bewteen points and model plane: current distance = (ax +
    % by + cz + d)/sqrt(a^2 + b^2 + c^2).
    c_dist = abs(sum(repmat(n_vec,nums,1).*point_data,2) + d)/norm(n_vec);
    c_inliers = find(c_dist < dist_threshold);
    count = length(c_inliers);
    
    %  check if the current model is the one with most voters
    if max_count < count
        max_count = count;
        inlier_indices = c_inliers;
        outlier_indices = setdiff([1:nums],inlier_indices);
    end
    % update iteration
    i = i + 1;
end

disp ('End RANSAC');
end

