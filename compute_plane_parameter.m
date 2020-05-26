function [plane_params] = compute_plane_parameter(ptCloud, inlierIndices)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANSAC_PLANEFITTING: To compute the plane parameters 
% Input: ptCloud: Point Cloud
%        inlierIndices: the indices of inliers
% Output: the parameters of dominant plane
% Witten by: Hong Zhang
% Email: hmz5180@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inlier_points = ptCloud.Location(inlierIndices,:);
nums = length(inlier_points);
% To compute the parameters of plane: [a, b, c, d]
% ax + by + cz + d = 0, we let c = 1. the  assumpsion is not always right
% but in this situation, it works, so the parameter of plane is [a, b, 1, z]
% then, build a equation like: A = [x0, y0, 1;x1, y1, 1; ...], B = [-z0;-z1;...]
% to solve the equation AX = B, where X = [a, b, d]
B = -inlier_points(:,3);
A = inlier_points;
A(:,3) = ones(nums, 1);

X = (A'*A)\(A'*B);

plane_params = [X(1), X(2), 1, X(3)];

end