function Projection(obj_3d, texture_path, dataset_path, result_path, ... 
                    int_paras, ext_paras)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJECTION Take a 3D object, and project it into a specific camera view
%
% Input: 
%       obj_3d              3D object
%       dataset_path        path of original image dataset
%       texture_path        path of texture of the 3D object
%       result_path         path of result folder
%       int_paras           internal parameters of the camera
%       ext_paras           external parameters of the camera
%
% Output: 
%       img2d  projected 2D image
%
% Witten by: Shimian Zhang
% Email: svz5303@psu.edu
% Course: Computer Vision Course, Spring 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Set camera parameters
    W = int_paras.W;
    H = int_paras.H;
    f = int_paras.paras(1);
    cx = int_paras.paras(2);
    cy = int_paras.paras(3);
    k = int_paras.paras(4);
    
    R = ext_paras.R;
    T = ext_paras.T';
    
    % compute camera pose
    orientation = R';
    location = -orientation*T;
    
    %% Load image and texture
    % read the original image
    img2d = imread(sprintf('%s/%s', dataset_path, ext_paras.Name));
    
    % read texture image
    texture = imread(texture_path);
    texture_img = flipdim(texture,1);
    [sy sx sz] = size(texture_img);
    texture_img =  reshape(texture_img,sy*sx,sz);
  
    %% Project 3D object
    figure();
    image(img2d);
    
    % project all vertices onto 2d image
    num = size(obj_3d.v,1);
    v_2d = zeros(num,2);
    for i=1:num
        Pw = obj_3d.v(i,:)';
        Pi = WorldToImage(Pw, f, cx, cy, k, R, T);
 
        x = floor(Pi(1));
        y = floor(Pi(2));
        v_2d(i,:) = [x,y];
    end
    
    % compute the distance of each face to the camera location
    num = size(obj_3d.f.v,1);
    df = size(num,1);
    for i=1:num
        % get vertex index of each face
        idx= obj_3d.f.v(i,:);

        a = v_2d(idx(1),:);
        b = v_2d(idx(2),:);
        c = v_2d(idx(3),:);
        % get distance of each vertex
        da = norm(obj_3d.v(idx(1),:)'-location);
        db = norm(obj_3d.v(idx(2),:)'-location);
        dc = norm(obj_3d.v(idx(3),:)'-location);
        
        % average
        df(i) = mean([da,db,dc]);
    end
    
    % sort the faces from farrest to nearest (Z-buffer concept)
    [~,rank] = sort(-df);
    
    obj_2d = obj_3d;
    obj_2d.v = v_2d;
    obj_2d.f.v = obj_3d.f.v(rank,:);
%     [vertex_idx fv_idx] = unique(obj_2d.f.v);
    obj_2d.f.vt = obj_3d.f.vt(rank,:);

    % fill the polygons from farest to nearest
%     for i=1:num
%         v_ids = obj_3d.f.v(i,:);
%         v = v_2d(v_ids,:);
%         % compute vertex color 
%         texture_idx = obj.f.vt() 
%     end
    display_obj(obj_2d,texture_path);
    
    % set the x and y limits
    xlim([1 size(img2d,2)])
    ylim([1 size(img2d,1)])   
    % set the x, y and z invisible
    set(gca,'xtick',[],'ytick',[],'xcolor','white','ycolor','white');
    drawnow
    
    names = split(ext_paras.Name,'.');
    saveas(gcf, sprintf('%s/projection_%s.png', result_path, names{1}))



    close;

    
return

