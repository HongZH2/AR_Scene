function obj_3d = dominant_plane_finding(ptCloud, obj_3d, obj_colormap)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fitting Plane Script: To fit a dominant plane in the point cloud 
% Witten by: Hong Zhang
% Email: hmz5180@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% draw a figure to show the original point cloud
figure()
pcshow(ptCloud)
title('Original Point Cloud')
xlabel('x')
ylabel('y')
zlabel('z')

%% set the threshold for RANSAC
maxDistance = 0.03; % the distance between model plane and points 
max_iteration = 6000; % just set a large numbers for convience
max_iteration = 60;
% Start RANSAC Algorith to fit the dominant plane
[inlierIndices,outlierIndices] = RANSAC_PlaneFitting(ptCloud, maxDistance, max_iteration);

% compute the parameter of Plane by the inliers
parameters_plane = compute_plane_parameter(ptCloud, inlierIndices);

%% Visualize the inliers and outliers by changing the color of points
ptCloud_results = ptCloud.copy();
ptCloud_results.Color(inlierIndices,:) = repmat(uint8([0,255,0]), length(inlierIndices), 1);

%% Import the obj file

% build a designed coordinate in the dominant plane
[obj_Origin, obj_Up, obj_Forw, obj_Left] = build_object_coordinate(parameters_plane);
% transform the object local coordinate into the designed coordinate
[obj_3d, trans_obj] = transform_3Dobject(obj_3d, obj_Origin, obj_Up, obj_Forw, obj_Left);


%% draw a figure to show the plane
figure()
pcshow(ptCloud_results)
title('Dominant Ground Plane')
xlabel('x')
ylabel('y')
zlabel('z')

%% draw a figure to show the point cloud with refined plane
figure()
pcshow(ptCloud)
title('Point Cloud With the Refined Plane ')
xlabel('x')
ylabel('y')
zlabel('z')
hold on 
[x, y] = meshgrid(-2:0.1:10, -2:0.1:4);
z = -(parameters_plane(1).*x + parameters_plane(2).*y + parameters_plane(4));
surf(x,y,z);

% set the normal vector of plane as the up vector of camera
campos([0 0 0])
camup(obj_Up)
camzoom(1.5)

set(gca,'xtick',[],'ytick',[],'ztick',[],'xcolor','black','ycolor','black','zcolor','black');

%% draw a figure to show the scene with placed 3D object
figure()
pcshow(ptCloud)
title('Point Cloud with placed 3D object on the ground')
xlabel('x')
ylabel('y')
zlabel('z')

% render the 3d object
hold on
display_obj(obj_3d, obj_colormap);

% draw the refined plane
hold on 
[x, y] = meshgrid(-2:0.1:10, -2:0.1:4);
z = -(parameters_plane(1).*x + parameters_plane(2).*y + parameters_plane(4));
surf(x,y,z);

% set the normal vector of plane as the up vector of camera
campos([0 0 0])
camup(obj_Up)
camzoom(2)
% Add a camera light, and tone down the specular highlighting
%camlight('headlight');

%draw the  designed object coordinate
hold on
plot3(obj_Origin(1), obj_Origin(2), obj_Origin(3),'r.','MarkerSize',10)
line([obj_Origin(1), obj_Origin(1)+obj_Up(1)], [obj_Origin(2),obj_Origin(2)+obj_Up(2)], [obj_Origin(3),obj_Origin(3)+obj_Up(3)], 'color','r', 'LineWidth',1)
line([obj_Origin(1), obj_Origin(1)+obj_Left(1)], [obj_Origin(2),obj_Origin(2)+obj_Left(2)], [obj_Origin(3),obj_Origin(3)+obj_Left(3)], 'color','g', 'LineWidth',4)
line([obj_Origin(1), obj_Origin(1)+obj_Forw(1)], [obj_Origin(2),obj_Origin(2)+obj_Forw(2)], [obj_Origin(3),obj_Origin(3)+obj_Forw(3)], 'color','b', 'LineWidth',4)

hold on
plot3(0, 0, 0,'r.','MarkerSize',2)
line([0, 1], [0, 0], [0, 0], 'color','r', 'LineWidth',1)
line([0, 0], [0, 1], [0, 0], 'color','g', 'LineWidth',1)
line([0, 0], [0, 0], [0, 1], 'color','b', 'LineWidth',1)

% set the x, y and z invisible
set(gca,'xtick',[],'ytick',[],'ztick',[],'xcolor','black','ycolor','black','zcolor','black');
end

